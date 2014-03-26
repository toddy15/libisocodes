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
    public class Test_ISO_639_5 : Object
    {
        public static void add_tests()
        {
            Test.add_func("/iso_639_5/3.x/create class", () => {
                var i = new ISO_639_5();
                assert(i != null);
                assert(i.standard == "639-5");
                assert(i.get_filepath() == "/usr/share/xml/iso-codes/iso_639_5.xml");
            });
            Test.add_func("/iso_639_5/3.x/create class with changed filepath", () => {
                var i = new ISO_639_5();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_639_5.xml");
                assert(i.get_filepath() == Config.TESTDIR + "/3.x/iso_639_5.xml");
                assert(i.standard == "639-5");
                try {
                    assert(i.get_iso_codes_xml_version() == "3");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639_5/3.x/find all codes", () => {
                var i = new ISO_639_5();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_639_5.xml");
                try {
                    var e = i.find_all();
                    assert(i.get_iso_codes_xml_version() == "3");
                    assert(e != null);
                    // Check expected number of entries
                    assert(e.length == 3);
                    // Check first and last entry
                    assert(e[0].id == "aus");
                    assert(e[0].parents == "");
                    assert(e[0].name == "Australian languages");
                    assert(e[e.length-1].id == "tut");
                    assert(e[e.length-1].parents == "");
                    assert(e[e.length-1].name == "Altaic languages");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639_5/3.x/find all codes in locale 'fr'", () => {
                var i = new ISO_639_5();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_639_5.xml");
                try {
                    i.set_locale("fr");
                    var e = i.find_all();
                    assert(e != null);
                    // Check expected number of entries
                    assert(e.length == 3);
                    // Check first and last translated entry
                    assert(e[0].id == "aus");
                    assert(e[0].parents == "");
                    assert(e[0].name == "australiennes, langues");
                    assert(e[e.length-1].id == "tut");
                    assert(e[e.length-1].parents == "");
                    assert(e[e.length-1].name == "altaïques, langues");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639_5/3.x/call find_code() without argument", () => {
                var i = new ISO_639_5();
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
            Test.add_func("/iso_639_5/3.x/search empty code", () => {
                var i = new ISO_639_5();
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
            Test.add_func("/iso_639_5/3.x/find code 'aus'", () => {
                var i = new ISO_639_5();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_639_5.xml");
                try {
                    var e = i.find_code("aus");
                    assert(i.get_iso_codes_xml_version() == "3");
                    assert(e != null);
                    assert(e is ISO_639_5_Item);
                    assert(e.id == "aus");
                    assert(e.parents == "");
                    assert(e.name == "Australian languages");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639_5/3.x/find code 'Sh00004044'", () => {
                var i = new ISO_639_5();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_639_5.xml");
                try {
                    var e = i.find_code("Sh00004044");
                    assert(e != null);
                    assert(e is ISO_639_5_Item);
                    assert(e.id == "sh00004044");
                    assert(e.parents == "sh85067921");
                    assert(e.name == "Gurani language");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639_5/3.x/find code 'TUT'", () => {
                var i = new ISO_639_5();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_639_5.xml");
                try {
                    var e = i.find_code("TUT");
                    assert(e != null);
                    assert(e is ISO_639_5_Item);
                    assert(e.id == "tut");
                    assert(e.parents == "");
                    assert(e.name == "Altaic languages");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639_5/3.x/search non existant code", () => {
                var i = new ISO_639_5();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_639_5.xml");
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
            Test.add_func("/iso_639_5/3.x/find code 'tut' in locale 'fr'", () => {
                var i = new ISO_639_5();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_639_5.xml");
                try {
                    i.set_locale("fr");
                    var e = i.find_code("tut");
                    assert(e != null);
                    assert(e is ISO_639_5_Item);
                    assert(e.id == "tut");
                    assert(e.parents == "");
                    assert(e.name == "altaïques, langues");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639_5/3.x/find code 'auS' in locale 'de'", () => {
                var i = new ISO_639_5();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_639_5.xml");
                try {
                    i.set_locale("de");
                    var e = i.find_code("auS");
                    assert(e != null);
                    assert(e is ISO_639_5_Item);
                    assert(e.id == "aus");
                    assert(e.parents == "");
                    assert(e.name == "Australische Sprachen");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639_5/3.x/find code 'aus' in non existant locale", () => {
                var i = new ISO_639_5();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_639_5.xml");
                try {
                    i.set_locale("does-not-exist");
                    var e = i.find_code("aus");
                    assert(e != null);
                    assert(e is ISO_639_5_Item);
                    assert(e.id == "aus");
                    assert(e.parents == "");
                    assert(e.name == "Australian languages");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
        }
    }
}
