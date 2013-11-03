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
    public class ISO_3166_2 : ISO_Codes
    {
        /**
         * Constructor of class.
         * 
         * Call the setup() method, see there for reasoning.
         */
        public ISO_3166_2() {
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
            standard = "3166-2";
            set_filepath("/usr/share/xml/iso-codes/iso_3166_2.xml");
        }
        /**
         * Destructor of class.
         * 
         * It is needed to cleanup the LibXML parser to free memory.
         */
        ~ISO_3166_2() {
            Parser.cleanup();
        }
        /**
         * Return an array of all entries in the ISO standard.
         * 
         * @return array All ISO 3166-2 entries.
         */
        public ISO_3166_2_Entry[] find_all() throws ISOCodesError
        {
            ISO_3166_2_Entry[] result = null;
            var entries = _find_all();
            foreach (var entry in entries) {
                result += new ISO_3166_2_Entry(entry);
            }
            return result;
        }
        /**
         * Try to locate the given code in the XML file.
         * 
         * @param string Code to search for.
         * 
         * @return struct A matching ISO 3166-2 entry, if found.
         */
        public ISO_3166_2_Entry find_code(string code = "") throws ISOCodesError
        {
            var res = _find_code(code);
            return new ISO_3166_2_Entry(res);
        }
        /**
         * Set up the XPaths to try.
         * 
         * @param string Code to search for.
         */
        internal override string[] _get_xpaths(string code)
        {
            string[] xpaths = {};
            xpaths += "//iso_3166_2_entry[@code='" + code.up() + "']";
            return xpaths;
        }
        /**
         * @inheritDoc
         */
        internal override string[] _get_fields()
        {
            return {
                "code",
                "parent",
                "name",
            };
        }
    }
}
