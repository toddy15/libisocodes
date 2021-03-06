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
        private string _iso_codes_xml_version = "";
        /**
         * Get method for major version of the iso-codes XML files.
         * 
         * There is no set method because it does not make sense and
         * is therefore not necessary.
         * 
         * Currently, these methods need to be implemented instead
         * of using the built-in get/set methods.
         */
        public string get_iso_codes_xml_version() throws ISOCodesError {
            // If the variable is not set, the XML file has never been
            // opened, so do it now to return a correct value.
            if (_iso_codes_xml_version == "") {
                _open_file();
            }
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
         * If the new path is an empty string or NULL, the previous
         * value is not changed.
         * 
         * Currently, these methods need to be implemented instead
         * of using the built-in get/set methods.
         */
        public void set_filepath(string? path) {
            if (path == null || path == "") {
                return;
            }
            _filepath = path;
            // If there is an open file, free the associated libxml structures
            if (_xml != null) {
                delete _xml;
                _xml = null;
            }
            if (_ctx != null) {
                delete _ctx;
                _ctx = null;
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
         * If the new locale is an empty string or NULL, no locale
         * is used for the returned values.
         * 
         * Currently, these methods need to be implemented instead
         * of using the built-in get/set methods.
         */
        public void set_locale(string? locale) {
            _locale = locale;
        }
        /**
         * Pointer to the Xml.Doc structure of LibXML.
         */
        private Xml.Doc* _xml = null;
        /**
         * Pointer to the Xml.ParserCtxt structure of LibXML.
         */
        private Xml.ParserCtxt* _ctx = null;
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
            // Check that the file exists and is a regular file (not a directory).
            if (FileUtils.test(get_filepath(), FileTest.IS_REGULAR) == false) {
                throw new ISOCodesError.CANNOT_OPEN_FILE(
                    // # TRANSLATORS:
                    // # The placeholder is a filename, including the directory path.
                    _("The file \"%(filename)s\" could not be opened.")
                    .replace("%(filename)s", get_filepath())
                );
            }
            // Create a new parsing context, to be able to set parsing options.
            _ctx = new ParserCtxt();
            if (_ctx == null) {
                throw new ISOCodesError.CANNOT_CREATE_LIBXML_STRUCTURE(
                    _("An internal libxml structure could not be created.")
                );
            }
            // Do not print parser warnings and errors from libxml to stderr.
            _ctx->use_options(ParserOption.NOERROR + ParserOption.NOWARNING);
            // Try parsing the file and handle errors.
            _xml = _ctx->read_file(get_filepath());
            if (_xml == null) {
                throw new ISOCodesError.CANNOT_PARSE_FILE(
                    // # TRANSLATORS:
                    // # The placeholder is a filename, including the directory path.
                    _("The file \"%(filename)s\" could not be parsed correctly.")
                    .replace("%(filename)s", get_filepath())
                );
            }
            // Check that the file contains the expected data.
            var root_name = _xml->get_root_element()->name;
            // Make sure the expected standard uses the same notation,
            // e.g. 3166_2 instead of 3166-2.
            var expected_name = "iso_" + standard.replace("-", "_") + "_entries";
            if (root_name != expected_name) {
                throw new ISOCodesError.FILE_DOES_NOT_CONTAIN_ISO_DATA(
                    // # TRANSLATORS:
                    // # The first placeholder is a filename, including the directory path.
                    // # The second placeholder is an ISO standard, e.g. 3166 or 639-3.
                    _("The file \"%(filename)s\" does not contain valid ISO %(standard)s data.")
                    .replace("%(filename)s", get_filepath())
                    .replace("%(standard)s", standard)
                );
            }
            // @TODO: This must not be hardcoded after the new iso-codes XML structure is adopted.
            _iso_codes_xml_version = "3";
        }
        /**
         * Return an array of all items in the ISO standard.
         * 
         * @return array All ISO 3166 items.
         */
        internal ArrayList<HashMap<string, string>> _find_all() throws ISOCodesError
        {
            var result = new ArrayList<HashMap<string, string>>();
            var xpath = "//iso_" +  standard.replace("-", "_") + "_entry";
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
                var item = new HashMap<string, string>();
                foreach (var field in fields) {
                    item[field] = node->get_prop(field);
                    // Fields might be null, e.g. official name and
                    // common name. Set them to an empty string instead.
                    if (item[field] == null) {
                        item[field] = "";
                    }
                }
                // Special case for ISO 3166-2: Extract the country
                // and the type from the parent elements.
                if (standard == "3166-2") {
                    item["country"] = node->parent->parent->get_prop("code");
                    item["type"] = node->parent->get_prop("type");
                }
                // Try to get translations, if wanted
                if (_locale != null && _locale != "") {
                    _translate(item, _locale);
                }
                result.add(item);
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
                    // Special case for ISO 3166-2: Extract the country
                    // and the type from the parent elements.
                    if (standard == "3166-2") {
                        result["country"] = node->parent->parent->get_prop("code");
                        result["type"] = node->parent->get_prop("type");
                    }
                    did_not_find_code = false;
                    // Exit after successful match, to avoid matching the same
                    // item another time (can happen e.g. in ISO 639, where
                    // most items have the same value for their 2B and 2T code.
                    break;
                }
            }
            // Throw an error, if the code could not be found.
            if (did_not_find_code) {
                throw new ISOCodesError.CODE_NOT_DEFINED(
                    // # TRANSLATORS:
                    // # The first placeholder is a code, e.g. 'de' or 'hurgh'.
                    // # The second placeholder is an ISO standard, e.g. 3166 or 639-3.
                    _("The code \"%(code)s\" is not defined in ISO %(standard)s.")
                    .replace("%(code)s", code)
                    .replace("%(standard)s", standard)
                );
            }
            // Try to get translations, if wanted
            if (_locale != null && _locale != "") {
                _translate(result, _locale);
            }
            return result;
        }
        /**
         * Translate an item to the wanted locale.
         * 
         * @param HashMap<string, string> Entry to be translated
         * @param string Locale to use for translation
         */
        internal void _translate(HashMap<string, string> item, string locale)
        {
            // Specify which fields need translation
            string[] fields_to_translate = {
                "name",
                "official_name",
                "common_name",
                "currency_name"
            };
            // Save the current locale
            string loc_backup = Intl.setlocale(LocaleCategory.ALL, null);
            // Save the current setting of environment variable LANGUAGE.
            unowned string env = Environment.get_variable("LANGUAGE");
            var env_backup = env.dup();
            // Use the wanted locale to look for a translation
            Environment.set_variable("LANGUAGE", locale, true);
            // Use the default locale, based on the environment variable above
            Intl.setlocale(LocaleCategory.ALL, "");
            // Determine the gettext domain from the standard
            var domain = "iso_" + standard.replace("-", "_");
            foreach (var field in fields_to_translate) {
                if (item.has_key(field) && (item[field] != "")) {
                    item[field] = dgettext(domain, item[field]);
                }
            }
            // Restore the environment variable LANGUAGE, either
            // to the previous value or unset the variable.
            if (env_backup == null) {
                Environment.unset_variable("LANGUAGE");
            }
            else {
                Environment.set_variable("LANGUAGE", env_backup, true);
            }
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
