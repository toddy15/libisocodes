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
    public class Test_ISO_15924 : Object
    {
        public static void add_tests()
        {
            Test.add_func("/iso_15924/3.x/create class", () => {
                var i = new ISO_15924();
                assert(i != null);
                assert(i.standard == "15924");
                assert(i.get_filepath() == "/usr/share/xml/iso-codes/iso_15924.xml");
            });
            Test.add_func("/iso_15924/3.x/create class with changed filepath", () => {
                var i = new ISO_15924();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_15924.xml");
                assert(i.get_filepath() == Config.TESTDIR + "/3.x/iso_15924.xml");
                assert(i.standard == "15924");
                try {
                    assert(i.get_iso_codes_xml_version() == "3");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_15924/3.x/find all codes", () => {
                var i = new ISO_15924();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_15924.xml");
                try {
                    var e = i.find_all();
                    assert(i.get_iso_codes_xml_version() == "3");
                    assert(e != null);
                    // Check expected number of entries
                    assert(e.length == 4);
                    // Check first and last entry
                    assert(e[0].alpha_4_code == "Beng");
                    assert(e[0].numeric_code == "325");
                    assert(e[0].name == "Bengali");
                    assert(e[e.length-1].alpha_4_code == "Latn");
                    assert(e[e.length-1].numeric_code == "215");
                    assert(e[e.length-1].name == "Latin");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_15924/3.x/find all codes in locale 'fr'", () => {
                var i = new ISO_15924();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_15924.xml");
                try {
                    i.set_locale("fr");
                    var e = i.find_all();
                    assert(e != null);
                    // Check expected number of entries
                    assert(e.length == 4);
                    // Check first and last translated entry
                    assert(e[0].alpha_4_code == "Beng");
                    assert(e[0].numeric_code == "325");
                    assert(e[0].name == "Bengali");
                    assert(e[e.length-1].alpha_4_code == "Latn");
                    assert(e[e.length-1].numeric_code == "215");
                    assert(e[e.length-1].name == "latin");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_15924/3.x/call find_code() without argument", () => {
                var i = new ISO_15924();
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
            Test.add_func("/iso_15924/3.x/search empty code", () => {
                var i = new ISO_15924();
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
            Test.add_func("/iso_15924/3.x/find code 'Cyrl'", () => {
                var i = new ISO_15924();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_15924.xml");
                try {
                    var e = i.find_code("Cyrl");
                    assert(i.get_iso_codes_xml_version() == "3");
                    assert(e != null);
                    assert(e is ISO_15924_Item);
                    assert(e.alpha_4_code == "Cyrl");
                    assert(e.numeric_code == "220");
                    assert(e.name == "Cyrillic");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_15924/3.x/find code '200'", () => {
                var i = new ISO_15924();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_15924.xml");
                try {
                    var e = i.find_code("200");
                    assert(e != null);
                    assert(e is ISO_15924_Item);
                    assert(e.alpha_4_code == "Grek");
                    assert(e.numeric_code == "200");
                    assert(e.name == "Greek");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_15924/3.x/find code 'BENG'", () => {
                var i = new ISO_15924();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_15924.xml");
                try {
                    var e = i.find_code("BENG");
                    assert(e != null);
                    assert(e is ISO_15924_Item);
                    assert(e.alpha_4_code == "Beng");
                    assert(e.numeric_code == "325");
                    assert(e.name == "Bengali");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_15924/3.x/find code 'grEK'", () => {
                var i = new ISO_15924();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_15924.xml");
                try {
                    var e = i.find_code("grEK");
                    assert(e != null);
                    assert(e is ISO_15924_Item);
                    assert(e.alpha_4_code == "Grek");
                    assert(e.numeric_code == "200");
                    assert(e.name == "Greek");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_15924/3.x/search non existant code", () => {
                var i = new ISO_15924();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_15924.xml");
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
            Test.add_func("/iso_15924/3.x/find code 'Grek' in locale 'de'", () => {
                var i = new ISO_15924();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_15924.xml");
                try {
                    i.set_locale("de");
                    var e = i.find_code("Grek");
                    assert(e != null);
                    assert(e is ISO_15924_Item);
                    assert(e.alpha_4_code == "Grek");
                    assert(e.numeric_code == "200");
                    assert(e.name == "Griechisch");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_15924/3.x/find code '220' in locale 'fr'", () => {
                var i = new ISO_15924();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_15924.xml");
                try {
                    i.set_locale("fr");
                    var e = i.find_code("220");
                    assert(e != null);
                    assert(e is ISO_15924_Item);
                    assert(e.alpha_4_code == "Cyrl");
                    assert(e.numeric_code == "220");
                    assert(e.name == "cyrillique");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_15924/3.x/find code 'Latn' in non existant locale", () => {
                var i = new ISO_15924();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_15924.xml");
                try {
                    i.set_locale("does-not-exist");
                    var e = i.find_code("Latn");
                    assert(e != null);
                    assert(e is ISO_15924_Item);
                    assert(e.alpha_4_code == "Latn");
                    assert(e.numeric_code == "215");
                    assert(e.name == "Latin");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
        }
    }
}
