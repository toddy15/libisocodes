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
using Gee;

namespace libisocodes {
    public class ISO_3166 : ISO_Codes
    {
        /**
         * Constructor of class.
         * 
         * Call the setup() method, see there for reasoning.
         */
        public ISO_3166() {
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
            set_standard("3166");
            set_filepath("/usr/share/xml/iso-codes/iso_3166.xml");
            domain = "iso_" + get_standard();
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
         * Return an array of all entries in the ISO standard.
         * 
         * @param string Wanted locale, might be empty for English text.
         * 
         * @return array All ISO 3166 entries.
         */
        public ISO_3166_Entry[] find_all(string locale = "") throws ISOCodesError
        {
            ISO_3166_Entry[] result = null;
            var entries = _find_all(locale);
            foreach (var entry in entries) {
                result += new ISO_3166_Entry(entry);
            }
            return result;
        }
        /**
         * Try to locate the given code in the XML file.
         * 
         * @param string Code to search for.
         * @param string Wanted locale, might be empty for English text.
         * 
         * @return struct A matching ISO 3166 entry, if found.
         */
        public ISO_3166_Entry find_code(string code = "", string locale = "") throws ISOCodesError
        {
            var res = _find_code(code, locale);
            return new ISO_3166_Entry(res);
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
                xpaths += "//iso_3166_entry[@alpha_2_code='" + code.up() + "']";
            }
            else if (_is_number(code)) {
                xpaths += "//iso_3166_entry[@numeric_code='" + code.up() + "']";
            }
            else {
                xpaths += "//iso_3166_entry[@alpha_3_code='" + code.up() + "']";
            }
            return xpaths;
        }
        /**
         * @inheritDoc
         */
        internal override string[] _get_fields()
        {
            return {
                "alpha_2_code",
                "alpha_3_code",
                "numeric_code",
                "name",
                "official_name",
                "common_name"
            };
        }
    }
}
