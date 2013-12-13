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
    public class ISO_639_3 : ISO_Codes
    {
        /**
         * Constructor of class.
         * 
         * Call the setup() method, see there for reasoning.
         */
        public ISO_639_3() {
            setup();
        }
        /**
         * Setup of the class.
         * 
         * Due to a bug somewhere in the GObject introspection routines
         * with vala, the constructor of a class is not called when
         * the class is instanciated. Therefore, we use a separate
         * setup method which can be called, if necessary.
         * 
         * For LibXML, it is needed to initialize the parser here.
         */
        public void setup() {
            _setup_i18n();
            Parser.init();
            standard = "639-3";
            set_filepath("/usr/share/xml/iso-codes/iso_639_3.xml");
        }
        /**
         * Destructor of class.
         * 
         * It is needed to cleanup the LibXML parser to free memory.
         */
        ~ISO_639_3() {
            Parser.cleanup();
        }
        /**
         * Return an array of all items in the ISO standard.
         * 
         * @return array All ISO 639-3 items.
         */
        public ISO_639_3_Item[] find_all() throws ISOCodesError
        {
            ISO_639_3_Item[] result = null;
            var items = _find_all();
            foreach (var item in items) {
                result += new ISO_639_3_Item(item);
            }
            return result;
        }
        /**
         * Try to locate the given code in the XML file.
         * 
         * @param string Code to search for.
         * 
         * @return struct A matching ISO 639-3 item, if found.
         */
        public ISO_639_3_Item find_code(string code = "") throws ISOCodesError
        {
            var res = _find_code(code);
            return new ISO_639_3_Item(res);
        }
        /**
         * Set up the XPaths to try.
         * 
         * @param string Code to search for.
         */
        internal override string[] _get_xpaths(string code)
        {
            string[] xpaths = {};
            if (code.length == 2) {
                xpaths += "//iso_639_3_entry[@part1_code='" + code.down() + "']";
            }
            else {
                xpaths += "//iso_639_3_entry[@id='" + code.down() + "']";
                xpaths += "//iso_639_3_entry[@part2_code='" + code.down() + "']";
            }
            return xpaths;
        }
        /**
         * @inheritDoc
         */
        internal override string[] _get_fields()
        {
            return {
                "id",
                "part1_code",
                "part2_code",
                "status",
                "scope",
                "type",
                "inverted_name",
                "reference_name",
                "name",
                "common_name"
            };
        }
    }
}
