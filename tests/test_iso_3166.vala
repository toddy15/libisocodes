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

namespace libisocodes {
    public class Test_ISO_3166 : Object
    {
        public static void add_tests()
        {
            Test.add_func("/iso_3166/create class", () => {
                var i = new ISO_3166();
                assert(i != null);
                assert(i.standard == "3166");
                assert(i.filepath == "/usr/share/xml/iso-codes/iso_3166.xml");
            });
            Test.add_func("/iso_3166/create class with changed filepath", () => {
                var i = new ISO_3166();
                i.filepath = "/this/is/a/new/path";
                assert(i.filepath == "/this/is/a/new/path");
                assert(i.standard == "3166");
            });
            Test.add_func("/iso_3166/call search_code() without argument", () => {
                var i = new ISO_3166();
                try {
                    var e = i.search_code();
                    // This assert is just to use the variable e,
                    // otherwise the compiler emits a warning.
                    // It is not reached.
                    assert(e == null);
                }
                catch (ISOCodesError error) {
                }
            });
            Test.add_func("/iso_3166/search empty code", () => {
                var i = new ISO_3166();
                try {
                    var e = i.search_code("");
                    // This assert is just to use the variable e,
                    // otherwise the compiler emits a warning.
                    // It is not reached.
                    assert(e == null);
                }
                catch (ISOCodesError error) {
                }
            });
            Test.add_func("/iso_3166/search code 'de'", () => {
                var i = new ISO_3166();
                try {
                    var e = i.search_code("de");
                    assert(e != null);
                    assert(e is ISO_3166_Entry);
                    assert(e.alpha_2_code == "DE");
                    assert(e.alpha_3_code == "DEU");
                    assert(e.numeric_code == "276");
                    assert(e.name == "Germany");
                    assert(e.official_name == "Federal Republic of Germany");
                    assert(e.common_name == "");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_3166/search code 'FR'", () => {
                var i = new ISO_3166();
                try {
                    var e = i.search_code("FR");
                    assert(e != null);
                    assert(e is ISO_3166_Entry);
                    assert(e.alpha_2_code == "FR");
                    assert(e.alpha_3_code == "FRA");
                    assert(e.numeric_code == "250");
                    assert(e.name == "France");
                    assert(e.official_name == "French Republic");
                    assert(e.common_name == "");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_3166/search code 'Tw'", () => {
                var i = new ISO_3166();
                try {
                    var e = i.search_code("Tw");
                    assert(e != null);
                    assert(e is ISO_3166_Entry);
                    assert(e.alpha_2_code == "TW");
                    assert(e.alpha_3_code == "TWN");
                    assert(e.numeric_code == "158");
                    assert(e.name == "Taiwan, Province of China");
                    assert(e.official_name == "Taiwan, Province of China");
                    assert(e.common_name == "Taiwan");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_3166/search code 'ukr'", () => {
                var i = new ISO_3166();
                try {
                    var e = i.search_code("ukr");
                    assert(e != null);
                    assert(e is ISO_3166_Entry);
                    assert(e.alpha_2_code == "UA");
                    assert(e.alpha_3_code == "UKR");
                    assert(e.numeric_code == "804");
                    assert(e.name == "Ukraine");
                    assert(e.official_name == "");
                    assert(e.common_name == "");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_3166/search code '798'", () => {
                var i = new ISO_3166();
                try {
                    var e = i.search_code("798");
                    assert(e != null);
                    assert(e is ISO_3166_Entry);
                    assert(e.alpha_2_code == "TV");
                    assert(e.alpha_3_code == "TUV");
                    assert(e.numeric_code == "798");
                    assert(e.name == "Tuvalu");
                    assert(e.official_name == "");
                    assert(e.common_name == "");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_3166/search non existant code", () => {
                var i = new ISO_3166();
                try {
                    var e = i.search_code("not-there");
                    // This assert is just to use the variable e,
                    // otherwise the compiler emits a warning.
                    // It is not reached.
                    assert(e == null);
                }
                catch (ISOCodesError error) {
                }
            });
            Test.add_func("/iso_3166/search code 'ES' in locale 'de'", () => {
                var i = new ISO_3166();
                try {
                    var e = i.search_code("es", "de");
                    assert(e != null);
                    assert(e is ISO_3166_Entry);
                    assert(e.alpha_2_code == "ES");
                    assert(e.alpha_3_code == "ESP");
                    assert(e.numeric_code == "724");
                    assert(e.name == "Spanien");
                    assert(e.official_name == "Königreich Spanien");
                    assert(e.common_name == "");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_3166/search code 'TW' in locale 'fr'", () => {
                var i = new ISO_3166();
                try {
                    var e = i.search_code("TW", "fr");
                    assert(e != null);
                    assert(e is ISO_3166_Entry);
                    assert(e.alpha_2_code == "TW");
                    assert(e.alpha_3_code == "TWN");
                    assert(e.numeric_code == "158");
                    assert(e.name == "Taïwan, province de Chine");
                    assert(e.official_name == "Taïwan, province de Chine");
                    assert(e.common_name == "Taïwan");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
        }
    }
}
