/* Copyright © 2012-2013 Tobias Quathamer
 *
 * This file is part of libisocodes.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using Xml;
using Gee;

namespace libisocodes {
    public abstract class ISO_Codes : Object
    {
        /**
         * Major version of the iso-codes XML files.
         */
        private string _iso_codes_xml_version;
        /**
         * Get method for major version of the iso-codes XML files.
         * 
         * There is no set method because it does not make sense and
         * is therefore not necessary.
         * 
         * Currently, these methods need to be implemented instead
         * of using the built-in get/set methods.
         */
        public string get_iso_codes_xml_version() {
            return _iso_codes_xml_version;
        }
        /**
         * Path of the XML file with iso-codes data.
         */
        private string _filepath;
        /**
         * Get method for filepath of the XML file.
         * 
         * Currently, these methods need to be implemented instead
         * of using the built-in get/set methods.
         */
        public string get_filepath() {
            return _filepath;
        }
        /**
         * Set method for filepath of the XML file.
         * 
         * Currently, these methods need to be implemented instead
         * of using the built-in get/set methods.
         */
        public void set_filepath(string path) {
            _filepath = path;
            // If there is an open file, close it
            if (_xml != null) {
                delete _xml;
                _xml = null;
            }
        }
        /**
         * The ISO standard currently in use.
         */
        internal string standard { get; set; }
        /**
         * The output locale currently in use.
         */
        private string _locale;
        /**
         * Get method for output locale.
         * 
         * Currently, these methods need to be implemented instead
         * of using the built-in get/set methods.
         */
        public string get_locale() {
            return _locale;
        }
        /**
         * Set method for output locale.
         * 
         * Currently, these methods need to be implemented instead
         * of using the built-in get/set methods.
         */
        public void set_locale(string locale) {
            _locale = locale;
        }
        /**
         * Pointer to the Xml.Doc structure of LibXML.
         */
        private Xml.Doc* _xml = null;
        /**
         * Set up the i18n framework.
         * 
         * This method needs to be called by every subclass.
         */
        internal void _setup_i18n()
        {
            Intl.bindtextdomain(Config.GETTEXT_PACKAGE, Config.LOCALEDIR);
            Intl.bind_textdomain_codeset(Config.GETTEXT_PACKAGE, "UTF-8");
            Intl.setlocale(LocaleCategory.ALL, "");
        }
        /**
         * Open and parse the file.
         * 
         * This method checks that the file exists and tries to parse
         * it.
         * 
         * @param string Filename to open, defaults to filepath.
         */
        internal void _open_file(string name = "") throws ISOCodesError
        {
            // If the name is set, use it.
            if (name != "") {
                set_filepath(name);
            }
            // Check that the file exists.
            if (FileUtils.test(get_filepath(), FileTest.EXISTS) == false) {
                throw new ISOCodesError.FILE_DOES_NOT_EXIST(
                    // TRANSLATORS:
                    // The placeholder is a filename, including the directory path.
                    _("The file \"%s\" could not be opened.").printf(get_filepath())
                );
            }
            // Try parsing the file and handle errors.
            _xml = Parser.parse_file(get_filepath());
            if (_xml == null) {
                throw new ISOCodesError.CANNOT_PARSE_FILE(
                    // TRANSLATORS:
                    // The placeholder is a filename, including the directory path.
                    _("The file \"%s\" could not be parsed correctly.").printf(get_filepath())
                );
            }
            // Check that the file contains the expected data.
            var root_name = _xml->get_root_element()->name;
            // Make sure the expected standard uses the same notation,
            // e.g. 3166_2 instead of 3166-2.
            var expected_name = "iso_" + standard.replace("-", "_") + "_entries";
            if (root_name != expected_name) {
                throw new ISOCodesError.FILE_DOES_NOT_CONTAIN_ISO_DATA(
                    // TRANSLATORS:
                    // The first placeholder is a filename, including the directory path.
                    // The second placeholder is an ISO standard, e.g. 3166 or 639-3.
                    _("The file \"%s\" does not contain valid ISO %s data.").printf(get_filepath(), standard)
                );
            }
            // @TODO: This must not be hardcoded after the new iso-codes XML structure is adopted.
            _iso_codes_xml_version = "3";
        }
        /**
         * Return an array of all entries in the ISO standard.
         * 
         * @return array All ISO 3166 entries.
         */
        internal ArrayList<HashMap<string, string>> _find_all() throws ISOCodesError
        {
            var result = new ArrayList<HashMap<string, string>>();
            var xpath = "//iso_3166_entry";
            // Make sure the XML file is ready for reading
            if (_xml == null) {
                _open_file();
            }
            // Set up the XPath infrastructure
            var context = new XPath.Context(_xml);
            assert(context != null);
            // Try to match nodes against the XPath
            var obj = context.eval(xpath);
            // Get the result nodeset
            var nodeset = obj->nodesetval;
            var fields = _get_fields();
            for (var i = 0; i < nodeset->length(); i++) {
                var node = nodeset->item(i);
                var entry = new HashMap<string, string>();
                foreach (var field in fields) {
                    entry[field] = node->get_prop(field);
                    // Fields might be null, e.g. official name and
                    // common name. Set them to an empty string instead.
                    if (entry[field] == null) {
                        entry[field] = "";
                    }
                }
                // Try to get translations, if wanted
                if (_locale != null && _locale != "") {
                    _translate(entry, _locale);
                }
                result.add(entry);
            }
            return result;
        }
        /**
         * Find the given code or codes with the given XPath.
         * 
         * @param string Code to search for.
         */
        internal HashMap<string, string> _find_code(string code = "") throws ISOCodesError
        {
            var did_not_find_code = true;
            var result = new HashMap<string, string>();
            // Make sure the XML file is ready for reading
            if (_xml == null) {
                _open_file();
            }
            // Set up the XPath infrastructure
            var context = new XPath.Context(_xml);
            assert(context != null);
            // Get the XPaths needed for this code
            var xpaths = _get_xpaths(code);
            // See if there are results for any of the XPaths
            foreach (var xpath in xpaths) {
                // Try to match nodes against the XPath
                var obj = context.eval(xpath);
                // Get the result nodeset
                var nodeset = obj->nodesetval;
                // There can be only 1 matching node.
                if (nodeset->length() == 1) {
                    var fields = _get_fields();
                    var node = nodeset->item(0);
                    foreach (var field in fields) {
                        result[field] = node->get_prop(field);
                        // Fields might be null, e.g. official name and
                        // common name. Set them to an empty string instead.
                        if (result[field] == null) {
                            result[field] = "";
                        }
                    }
                    did_not_find_code = false;
                    // Exit after successful match, to avoid matching the same
                    // entry another time (can happen e.g. in ISO 639, where
                    // most entries have the same value for their 2B and 2T code.
                    break;
                }
            }
            // Throw an error, if the code could not be found.
            if (did_not_find_code) {
                throw new ISOCodesError.CODE_NOT_DEFINED(
                    // TRANSLATORS:
                    // The first placeholder is a code, e.g. 'de' or 'hurgh'.
                    // The second placeholder is an ISO standard, e.g. 3166 or 639-3.
                    _("The code \"%s\" is not defined in ISO %s.").printf(code, standard)
                );
            }
            // Try to get translations, if wanted
            if (_locale != null && _locale != "") {
                _translate(result, _locale);
            }
            return result;
        }
        /**
         * Translate an entry to the wanted locale.
         * 
         * @param HashMap<string, string> Entry to be translated
         * @param string Locale to use for translation
         */
        internal void _translate(HashMap<string, string> entry, string locale)
        {
            // Specify which fields need translation
            string[] fields_to_translate = {
                "name",
                "official_name",
                "common_name"
            };
            // Save the current locale
            string loc_backup = Intl.setlocale(LocaleCategory.ALL, null);
            // Use the user's locale
            Intl.setlocale(LocaleCategory.ALL, "");
            // Save the current setting of environment variable LANGUAGE.
            unowned string env = Environment.get_variable("LANGUAGE");
            var env_backup = env.dup();
            // Use the wanted locale to look for a translation
            Environment.set_variable("LANGUAGE", locale, true);
            // Determine the gettext domain from the standard
            var domain = "iso_" + standard.replace("-", "_");
            foreach (var field in fields_to_translate) {
                if (entry.has_key(field) && (entry[field] != "")) {
                    entry[field] = dgettext(domain, entry[field]);
                }
            }
            // Restore the environment from backup
            Environment.set_variable("LANGUAGE", env_backup, true);
            // Restore the locale from backup
            Intl.setlocale(LocaleCategory.ALL, loc_backup);
        }
        /**
         * Determine whether a given string represents a number.
         */
        internal bool _is_number(string text)
        {
            var contains_only_digits = true;
            var length = text.length;
            var index = 0;
            while (index < length) {
                if (!text[index].isdigit()) {
                    contains_only_digits = false;
                    break;
                }
                index++;
            }
            return contains_only_digits;
        }
        /**
         * Return all XPaths which should be tested with the given code.
         * 
         * @param string Code to search for, e.g. 'DE', 'DEU', '788'.
         * @return string[] Array of XPaths which are applicable to the code.
         */
        internal abstract string[] _get_xpaths(string code);
        /**
         * Return all fields of the current ISO standard.
         * 
         * This is needed for constructing the HashMap.
         * 
         * @return string[] Array with the names of all fields in the current standard.
         */
        internal abstract string[] _get_fields();
    }
}
