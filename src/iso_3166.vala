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
         * It is needed to initialize the LibXML parser here.
         */
        public ISO_3166() {
            _setup_i18n();
            Parser.init();
            standard = "3166";
            filepath = "/usr/share/xml/iso-codes/iso_3166.xml";
            domain = "iso_" + standard;
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
            /*
            var xpath = "//iso_3166_entry";
            XPath.NodeSet* nodeset = _search_code(xpath);
            for (var i = 0; i < nodeset->length(); i++) {
                result += new ISO_3166_Entry(nodeset->item(i));
            }
            */
            return result;
        }
        /**
         * Try to locate the given code in the XML file.
         * 
         * @param string Code to search for.
         * @param string Wanted locale, might be empty for default locale.
         */
        public ISO_3166_Entry search_code(string code = "", string locale = "") throws ISOCodesError
        {
            var res = _search_code(code);
            return new ISO_3166_Entry(res);
            /*
            // Try to get translations, if wanted
            if (locale != "") {
                // Save the current locale
                string loc_backup = Intl.setlocale(LocaleCategory.ALL, null);
                // Use the user's locale
                Intl.setlocale(LocaleCategory.ALL, "");
                // Save the current setting of environment variable LANGUAGE.
                unowned string env = Environment.get_variable("LANGUAGE");
                var env_backup = env.dup();
                // Use the wanted locale to look for a translation
                Environment.set_variable("LANGUAGE", locale, true);
                if (result.name != "") {
                    result.name = dgettext(domain, result.name);
                }
                if (result.official_name != "") {
                    result.official_name = dgettext(domain, result.official_name);
                }
                if (result.common_name != "") {
                    result.common_name = dgettext(domain, result.common_name);
                }
                // Restore the environment from backup
                Environment.set_variable("LANGUAGE", env_backup, true);
                // Restore the locale from backup
                Intl.setlocale(LocaleCategory.ALL, loc_backup);
            }
            */
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
