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
            _setup_i18n();
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
         * Return an array of all entries in the ISO standard.
         */
        public ISO_3166_Entry[] all_entries() throws ISOCodesError
        {
            ISO_3166_Entry[] result = null;
            return result;
        }
        /**
         * Try to locate the given code in the XML file.
         * 
         * @param string Code to search for.
         */
        public ISO_3166_Entry search_code(string code = "") throws ISOCodesError
        {
            ISO_3166_Entry result = null;
            var xpaths = _get_xpaths(code);
            // See if there are results for any of the XPaths
            foreach (var xpath in xpaths) {
                XPath.NodeSet* nodeset = _search_code(xpath);
                // There can be only 1 matching node.
                if (nodeset->length() == 1) {
                    result = new ISO_3166_Entry(nodeset->item(0));
                    // Exit after successful match, to avoid matching the same
                    // entry another time (can happen e.g. in ISO 639, where
                    // most entries have the same value for their 2B and 2T code
                    break;
                }
            }
            // If the result is still null, it means that
            // no result could be found. Therefore, throw an error.
            if (result == null) {
                throw new ISOCodesError.CODE_NOT_DEFINED(
                    _("The code '%s' is not defined in ISO %s.").printf(code, standard)
                );
            }
            return result;
        }
        /**
         * Set up the XPaths to try.
         * 
         * @param string Code to search for.
         */
        private string[] _get_xpaths(string code)
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
    }
}
