/* Copyright © 2012 Tobias Quathamer
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

namespace libisocodes {
    public class ISO_Codes : Object
    {
        /**
         * Path of the XML file with iso-codes data.
         */
        private string _filepath;
        /**
         * Get and set methods for path of the XML file.
         */
        public string filepath {
            get {
                return _filepath;
            }
            set {
                _filepath = value;
                // If there is an open file, close it
                if (_xml != null) {
                    delete _xml;
                    _xml = null;
                }
            }
        }
        /**
         * The ISO standard currently in use.
         */
        internal string standard { get; internal set; }
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
            Intl.textdomain(Config.GETTEXT_PACKAGE);
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
                filepath = name;
            }
            // Check that the file exists.
            if (FileUtils.test(filepath, FileTest.EXISTS) == false) {
                throw new ISOCodesError.FILE_DOES_NOT_EXIST(
                    // TRANSLATORS:
                    // The placeholder is a filename, including the directory path.
                    _("The file \"%s\" could not be opened.").printf(filepath)
                );
            }
            // Try parsing the file and handle errors.
            _xml = Parser.parse_file(filepath);
            if (_xml == null) {
                throw new ISOCodesError.CANNOT_PARSE_FILE(
                    // TRANSLATORS:
                    // The placeholder is a filename, including the directory path.
                    _("The file \"%s\" could not be parsed correctly.").printf(filepath)
                );
            }
            // Check that the file contains the expected data.
            var root_name = _xml->get_root_element()->name;
            // Make sure the expected standard uses the same notation,
            // e.g. 3166_2 instead of 3166-2.
            standard.replace("-", "_");
            var expected_name = "iso_" + standard + "_entries";
            if (root_name != expected_name) {
                throw new ISOCodesError.FILE_DOES_NOT_CONTAIN_ISO_DATA(
                    // TRANSLATORS:
                    // The first placeholder is a filename, including the directory path.
                    // The second placeholder is an ISO standard, e.g. 3166 or 639-3.
                    _("The file \"%s\" does not contain valid ISO %s data.").printf(filepath, standard)
                );
            }
        }
        /**
         * Find the given code in the given attributes of the current standard.
         */
         /*
        internal void*[] _find_code_in_attributes(string[] attributes, string code) throws ISOCodesError
        {
			void*[] result = {};
            
            // Set up the expected tag name
            var tag_name = "iso_" + standard.replace("-", "_") + "_entry";
            
            // Loop through all entries
            var iterator = _xml->get_root_element()->children;
            while (iterator != null) {
                // Only use the nodes, not text or comments
                if (iterator->type == ElementType.ELEMENT_NODE) {
                    if (iterator->name == tag_name) {
                        foreach (var attribute in attributes) {
                            if (iterator->get_prop(attribute) == code) {
                                result += (void*) new ISO_3166_Entry(iterator);
                                break;
                            }
                        }
                    }
                }
                iterator = iterator->next;
            }
            delete iterator;
            return result;
        }
        */
        /**
         * Find the given code with the given XPath.
         */
        internal XPath.NodeSet* _search_code(string xpath) throws ISOCodesError
        {
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
            return obj->nodesetval;
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
    }
}
