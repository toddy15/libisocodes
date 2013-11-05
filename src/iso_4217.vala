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
    public class ISO_4217 : ISO_Codes
    {
        /**
         * Constructor of class.
         * 
         * Call the setup() method, see there for reasoning.
         */
        public ISO_4217() {
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
            standard = "4217";
            set_filepath("/usr/share/xml/iso-codes/iso_4217.xml");
        }
        /**
         * Destructor of class.
         * 
         * It is needed to cleanup the LibXML parser to free memory.
         */
        ~ISO_4217() {
            Parser.cleanup();
        }
        /**
         * Return an array of all entries in the ISO standard.
         * 
         * @return array All ISO 4217 entries.
         */
        public ISO_4217_Entry[] find_all() throws ISOCodesError
        {
            ISO_4217_Entry[] result = null;
            var entries = _find_all();
            foreach (var entry in entries) {
                result += new ISO_4217_Entry(entry);
            }
            return result;
        }
        /**
         * Try to locate the given code in the XML file.
         * 
         * @param string Code to search for.
         * 
         * @return struct A matching ISO 4217 entry, if found.
         */
        public ISO_4217_Entry find_code(string code = "") throws ISOCodesError
        {
            var res = _find_code(code);
            return new ISO_4217_Entry(res);
        }
        /**
         * Set up the XPaths to try.
         * 
         * @param string Code to search for.
         */
        internal override string[] _get_xpaths(string code)
        {
            string[] xpaths = {};
            if (_is_number(code)) {
                xpaths += "//iso_4217_entry[@numeric_code='" + code.up() + "']";
            }
            else {
                xpaths += "//iso_4217_entry[@letter_code='" + code.up() + "']";
            }
            return xpaths;
        }
        /**
         * @inheritDoc
         */
        internal override string[] _get_fields()
        {
            return {
                "letter_code",
                "numeric_code",
                "currency_name"
            };
        }
    }
}
