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

namespace libisocodes {
    public class Test_ISO_3166 : Object
    {
        public static void add_tests()
        {
            Test.add_func("/iso_3166/create class", () => {
                var i = new ISO_3166();
                assert(i != null);
                assert(i.standard == "3166");
                assert(i.get_filepath() == "/usr/share/xml/iso-codes/iso_3166.xml");
            });
            Test.add_func("/iso_3166/create class with changed filepath", () => {
                var i = new ISO_3166();
                i.set_filepath(Config.TESTDIR + "/iso_3166.xml");
                assert(i.get_filepath() == Config.TESTDIR + "/iso_3166.xml");
                assert(i.standard == "3166");
                try {
                    assert(i.get_iso_codes_xml_version() == "3");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_3166/find all codes", () => {
                var i = new ISO_3166();
                i.set_filepath(Config.TESTDIR + "/iso_3166.xml");
                try {
                    var e = i.find_all();
                    assert(i.get_iso_codes_xml_version() == "3");
                    assert(e != null);
                    // Check expected number of entries
                    assert(e.length == 7);
                    // Check first and last entry
                    assert(e[0].alpha_2_code == "DE");
                    assert(e[0].alpha_3_code == "DEU");
                    assert(e[0].numeric_code == "276");
                    assert(e[0].name == "Germany");
                    assert(e[0].official_name == "Federal Republic of Germany");
                    assert(e[0].common_name == "");
                    assert(e[e.length-1].alpha_2_code == "UA");
                    assert(e[e.length-1].alpha_3_code == "UKR");
                    assert(e[e.length-1].numeric_code == "804");
                    assert(e[e.length-1].name == "Ukraine");
                    assert(e[e.length-1].official_name == "");
                    assert(e[e.length-1].common_name == "");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_3166/find all codes in locale 'fr'", () => {
                var i = new ISO_3166();
                i.set_filepath(Config.TESTDIR + "/iso_3166.xml");
                try {
                    i.set_locale("fr");
                    var e = i.find_all();
                    assert(e != null);
                    // Check expected number of entries
                    assert(e.length == 7);
                    // Check first and last translated entry
                    assert(e[0].alpha_2_code == "DE");
                    assert(e[0].alpha_3_code == "DEU");
                    assert(e[0].numeric_code == "276");
                    assert(e[0].name == "Allemagne");
                    assert(e[0].official_name == "République fédérale d'Allemagne");
                    assert(e[0].common_name == "");
                    assert(e[5].alpha_2_code == "TW");
                    assert(e[5].alpha_3_code == "TWN");
                    assert(e[5].numeric_code == "158");
                    assert(e[5].name == "Taïwan, province de Chine");
                    assert(e[5].official_name == "Taïwan, province de Chine");
                    assert(e[5].common_name == "Taïwan");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_3166/call find_code() without argument", () => {
                var i = new ISO_3166();
                try {
                    var e = i.find_code();
                    // This assert is just to use the variable e,
                    // otherwise the compiler emits a warning.
                    // It is not reached.
                    assert(e == null);
                    assert_not_reached();
                }
                catch (ISOCodesError error) {
                }
            });
            Test.add_func("/iso_3166/search empty code", () => {
                var i = new ISO_3166();
                try {
                    var e = i.find_code("");
                    // This assert is just to use the variable e,
                    // otherwise the compiler emits a warning.
                    // It is not reached.
                    assert(e == null);
                    assert_not_reached();
                }
                catch (ISOCodesError error) {
                }
            });
            Test.add_func("/iso_3166/find code 'de'", () => {
                var i = new ISO_3166();
                i.set_filepath(Config.TESTDIR + "/iso_3166.xml");
                try {
                    var e = i.find_code("de");
                    assert(i.get_iso_codes_xml_version() == "3");
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
            Test.add_func("/iso_3166/find code 'FR'", () => {
                var i = new ISO_3166();
                i.set_filepath(Config.TESTDIR + "/iso_3166.xml");
                try {
                    var e = i.find_code("FR");
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
            Test.add_func("/iso_3166/find code 'Tw'", () => {
                var i = new ISO_3166();
                i.set_filepath(Config.TESTDIR + "/iso_3166.xml");
                try {
                    var e = i.find_code("Tw");
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
            Test.add_func("/iso_3166/find code 'ukr'", () => {
                var i = new ISO_3166();
                i.set_filepath(Config.TESTDIR + "/iso_3166.xml");
                try {
                    var e = i.find_code("ukr");
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
            Test.add_func("/iso_3166/find code '798'", () => {
                var i = new ISO_3166();
                i.set_filepath(Config.TESTDIR + "/iso_3166.xml");
                try {
                    var e = i.find_code("798");
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
                i.set_filepath(Config.TESTDIR + "/iso_3166.xml");
                try {
                    var e = i.find_code("not-there");
                    // This assert is just to use the variable e,
                    // otherwise the compiler emits a warning.
                    // It is not reached.
                    assert(e == null);
                    assert_not_reached();
                }
                catch (ISOCodesError error) {
                }
            });
            Test.add_func("/iso_3166/find code 'ES' in locale 'de'", () => {
                var i = new ISO_3166();
                i.set_filepath(Config.TESTDIR + "/iso_3166.xml");
                try {
                    i.set_locale("de");
                    var e = i.find_code("es");
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
            Test.add_func("/iso_3166/find code 'TW' in locale 'fr'", () => {
                var i = new ISO_3166();
                i.set_filepath(Config.TESTDIR + "/iso_3166.xml");
                try {
                    i.set_locale("fr");
                    var e = i.find_code("TW");
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
            Test.add_func("/iso_3166/find code 'RUS' in non existant locale", () => {
                var i = new ISO_3166();
                i.set_filepath(Config.TESTDIR + "/iso_3166.xml");
                try {
                    i.set_locale("does-not-exist");
                    var e = i.find_code("RUS");
                    assert(e != null);
                    assert(e is ISO_3166_Entry);
                    assert(e.alpha_2_code == "RU");
                    assert(e.alpha_3_code == "RUS");
                    assert(e.numeric_code == "643");
                    assert(e.name == "Russian Federation");
                    assert(e.official_name == "");
                    assert(e.common_name == "");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
        }
    }
}
