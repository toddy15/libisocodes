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
    public class Test_ISO_639 : Object
    {
        public static void add_tests()
        {
            Test.add_func("/iso_639/3.x/create class", () => {
                var i = new ISO_639();
                assert(i != null);
                assert(i.standard == "639");
                assert(i.get_filepath() == "/usr/share/xml/iso-codes/iso_639.xml");
            });
            Test.add_func("/iso_639/3.x/create class with changed filepath", () => {
                var i = new ISO_639();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_639.xml");
                assert(i.get_filepath() == Config.TESTDIR + "/3.x/iso_639.xml");
                assert(i.standard == "639");
                try {
                    assert(i.get_iso_codes_xml_version() == "3");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639/3.x/find all codes", () => {
                var i = new ISO_639();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_639.xml");
                try {
                    var e = i.find_all();
                    assert(i.get_iso_codes_xml_version() == "3");
                    assert(e != null);
                    // Check expected number of entries
                    assert(e.length == 4);
                    // Check first and last entry
                    assert(e[0].iso_639_2B_code == "aar");
                    assert(e[0].iso_639_2T_code == "aar");
                    assert(e[0].iso_639_1_code == "aa");
                    assert(e[0].name == "Afar");
                    assert(e[e.length-1].iso_639_2B_code == "tib");
                    assert(e[e.length-1].iso_639_2T_code == "bod");
                    assert(e[e.length-1].iso_639_1_code == "bo");
                    assert(e[e.length-1].name == "Tibetan");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639/3.x/find all codes in locale 'fr'", () => {
                var i = new ISO_639();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_639.xml");
                try {
                    i.set_locale("fr");
                    var e = i.find_all();
                    assert(e != null);
                    // Check expected number of entries
                    assert(e.length == 4);
                    // Check first and last translated entry
                    assert(e[0].iso_639_2B_code == "aar");
                    assert(e[0].iso_639_2T_code == "aar");
                    assert(e[0].iso_639_1_code == "aa");
                    assert(e[0].name == "afar");
                    assert(e[e.length-1].iso_639_2B_code == "tib");
                    assert(e[e.length-1].iso_639_2T_code == "bod");
                    assert(e[e.length-1].iso_639_1_code == "bo");
                    assert(e[e.length-1].name == "tibétain");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639/3.x/call find_code() without argument", () => {
                var i = new ISO_639();
                try {
                    var e = i.find_code();
                    // This assert is just to use the variable e,
                    // otherwise the compiler emits a warning.
                    // It is not reached.
                    assert(e == null);
                    assert_not_reached();
                }
                catch (ISOCodesError error) {
                    assert(error is ISOCodesError.CODE_NOT_DEFINED);
                    assert(error.message == "The code \"\" is not defined in ISO " + i.standard + ".");
                }
            });
            Test.add_func("/iso_639/3.x/search empty code", () => {
                var i = new ISO_639();
                try {
                    var e = i.find_code("");
                    // This assert is just to use the variable e,
                    // otherwise the compiler emits a warning.
                    // It is not reached.
                    assert(e == null);
                    assert_not_reached();
                }
                catch (ISOCodesError error) {
                    assert(error is ISOCodesError.CODE_NOT_DEFINED);
                    assert(error.message == "The code \"\" is not defined in ISO " + i.standard + ".");
                }
            });
            Test.add_func("/iso_639/3.x/find code 'ALG'", () => {
                var i = new ISO_639();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_639.xml");
                try {
                    var e = i.find_code("ALG");
                    assert(i.get_iso_codes_xml_version() == "3");
                    assert(e != null);
                    assert(e is ISO_639_Item);
                    assert(e.iso_639_2B_code == "alg");
                    assert(e.iso_639_2T_code == "alg");
                    assert(e.iso_639_1_code == "");
                    assert(e.name == "Algonquian languages");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639/3.x/find code 'Tib'", () => {
                var i = new ISO_639();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_639.xml");
                try {
                    var e = i.find_code("Tib");
                    assert(e != null);
                    assert(e is ISO_639_Item);
                    assert(e.iso_639_2B_code == "tib");
                    assert(e.iso_639_2T_code == "bod");
                    assert(e.iso_639_1_code == "bo");
                    assert(e.name == "Tibetan");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639/3.x/find code 'bod'", () => {
                var i = new ISO_639();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_639.xml");
                try {
                    var e = i.find_code("bod");
                    assert(e != null);
                    assert(e is ISO_639_Item);
                    assert(e.iso_639_2B_code == "tib");
                    assert(e.iso_639_2T_code == "bod");
                    assert(e.iso_639_1_code == "bo");
                    assert(e.name == "Tibetan");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639/3.x/find code 'aA'", () => {
                var i = new ISO_639();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_639.xml");
                try {
                    var e = i.find_code("aA");
                    assert(e != null);
                    assert(e is ISO_639_Item);
                    assert(e.iso_639_2B_code == "aar");
                    assert(e.iso_639_2T_code == "aar");
                    assert(e.iso_639_1_code == "aa");
                    assert(e.name == "Afar");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639/3.x/search non existant code", () => {
                var i = new ISO_639();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_639.xml");
                try {
                    var e = i.find_code("not-there");
                    // This assert is just to use the variable e,
                    // otherwise the compiler emits a warning.
                    // It is not reached.
                    assert(e == null);
                    assert_not_reached();
                }
                catch (ISOCodesError error) {
                    assert(error is ISOCodesError.CODE_NOT_DEFINED);
                    assert(error.message == "The code \"not-there\" is not defined in ISO " + i.standard + ".");
                }
            });
            Test.add_func("/iso_639/3.x/find code 'he' in locale 'fr'", () => {
                var i = new ISO_639();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_639.xml");
                try {
                    i.set_locale("fr");
                    var e = i.find_code("he");
                    assert(e != null);
                    assert(e is ISO_639_Item);
                    assert(e.iso_639_2B_code == "heb");
                    assert(e.iso_639_2T_code == "heb");
                    assert(e.iso_639_1_code == "he");
                    assert(e.name == "hébreu");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639/3.x/find code 'hEB' in locale 'pl'", () => {
                var i = new ISO_639();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_639.xml");
                try {
                    i.set_locale("pl");
                    var e = i.find_code("hEB");
                    assert(e != null);
                    assert(e is ISO_639_Item);
                    assert(e.iso_639_2B_code == "heb");
                    assert(e.iso_639_2T_code == "heb");
                    assert(e.iso_639_1_code == "he");
                    assert(e.name == "hebrajski");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639/3.x/find code 'alg' in non existant locale", () => {
                var i = new ISO_639();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_639.xml");
                try {
                    i.set_locale("does-not-exist");
                    var e = i.find_code("alg");
                    assert(e != null);
                    assert(e is ISO_639_Item);
                    assert(e.iso_639_2B_code == "alg");
                    assert(e.iso_639_2T_code == "alg");
                    assert(e.iso_639_1_code == "");
                    assert(e.name == "Algonquian languages");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
        }
    }
}
