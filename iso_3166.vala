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
    public class ISO_3166 : ISO_Codes
    {
        /**
         * Constructor of class.
         * 
         * It is needed to initialize the LibXML parser here.
         */
        public ISO_3166() {
            Parser.init();
            standard = "3166";
            filepath = "/usr/share/xml/iso-codes/iso_3166.xml";
        }
        /**
         * Destructor of class.
         * 
         * It is needed to cleanup the LibXML parser to free memory.
         */
        ~ISO_3166() {
            Parser.cleanup();
        }
        /**
         * Open the given file and check if it contains the expected data.
         */
        public new void open_file(string name = "") throws ISOCodesError
        {
            // Open and parse the file
            base.open_file(name);
        }
        /**
         * This method tries to locate the given code in the XML file.
         * 
         * @param string Code to search for.
         */
        public ISO_3166_Entry[] search_code(string code = "")
        {
            string[] attributes = {"alpha_2_code", "alpha_3_code", "numeric_code"};
            ISO_3166_Entry[] results = {};
            var iterator = _xml->get_root_element()->children;
            // Loop through all entries
            while (iterator != null) {
                // Only use the nodes, not text or comments
                if (iterator->type == ElementType.ELEMENT_NODE) {
                    if (iterator->name == "iso_3166_entry") {
                        foreach (var attribute in attributes) {
                            if (iterator->get_prop(attribute) == code.up()) {
                                results += new ISO_3166_Entry(iterator);
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
