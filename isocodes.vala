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

namespace isocodes {
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
         * Pointer to the Xml.Doc structure of LibXML.
         */
        protected Xml.Doc* _xml = null;
        /**
         * Open and parse the file.
         * 
         * This method checks that the file exists and tries to parse
         * it.
         * 
         * @param string Filename to open, defaults to filepath.
         * @param string ISO standard to expect in the file.
         */
        public void open_file(string name = "", string standard = "") throws ISOCodesError
        {
            // If the name is set, use it.
            if (name != "") {
                filepath = name;
            }
            // Check that the file exists.
            if (FileUtils.test(filepath, FileTest.EXISTS) == false) {
                throw new ISOCodesError.FILE_DOES_NOT_EXIST(
                    @"The file '$filepath' does not exist."
                );
            }
            // Try parsing the file and handle errors.
            _xml = Parser.parse_file(filepath);
            if (_xml == null) {
                throw new ISOCodesError.CANNOT_PARSE_FILE(
                    @"The file '$filepath' could not be parsed correctly."
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
                    @"The file '$filepath' does not contain valid ISO $standard data."
                );
            }
        }
        /**
         * This method tries to locate the given code in the XML file.
         * 
         * @param string Code to search for.
         */
        public void search_code(string code = "")
        {
            stdout.printf("CODE: %s\n", code);
            string[] test = _find_string_in_attributes(code,
                {"alpha_2_code", "alpha_3_code", "numeric_code"});
            foreach (var t in test) {
                stdout.printf("T: %s\n", t);
            }
        }
        protected string[] _find_string_in_attributes(string phrase, string[] attributes)
        {
            string[] results = {};
            var iterator = _xml->get_root_element()->children;
            // Loop through all entries
            while (iterator != null) {
                // Only use the nodes, not text or comments
                if (iterator->type == ElementType.ELEMENT_NODE) {
                    if (iterator->name == "iso_3166_entry") {
                        foreach (var attribute in attributes) {
                            if (iterator->get_prop(attribute) == phrase.up()) {
                                results += iterator->get_prop("name");
                            }
                        }
                    }
                }
                iterator = iterator->next;
            }
            delete iterator;
            return results;
        }
    }
}
