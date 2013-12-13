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
    public class Test_ISO_3166_2 : Object
    {
        public static void add_tests()
        {
            Test.add_func("/iso_3166_2/3.x/create class", () => {
                var i = new ISO_3166_2();
                assert(i != null);
                assert(i.standard == "3166-2");
                assert(i.get_filepath() == "/usr/share/xml/iso-codes/iso_3166_2.xml");
            });
            Test.add_func("/iso_3166_2/3.x/create class with changed filepath", () => {
                var i = new ISO_3166_2();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_3166_2.xml");
                assert(i.get_filepath() == Config.TESTDIR + "/3.x/iso_3166_2.xml");
                assert(i.standard == "3166-2");
                try {
                    assert(i.get_iso_codes_xml_version() == "3");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_3166_2/3.x/find all codes", () => {
                var i = new ISO_3166_2();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_3166_2.xml");
                try {
                    var e = i.find_all();
                    assert(i.get_iso_codes_xml_version() == "3");
                    assert(e != null);
                    // Check expected number of entries
                    assert(e.length == 237);
                    // Check first and last entry
                    assert(e[0].country == "DE");
                    assert(e[0].type == "State");
                    assert(e[0].code == "DE-BW");
                    assert(e[0].parent == "");
                    assert(e[0].name == "Baden-Württemberg");
                    assert(e[e.length-1].country == "ES");
                    assert(e[e.length-1].type == "Autonomous city");
                    assert(e[e.length-1].code == "ES-ML");
                    assert(e[e.length-1].parent == "");
                    assert(e[e.length-1].name == "Melilla");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_3166_2/3.x/find all codes in locale 'fr'", () => {
                var i = new ISO_3166_2();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_3166_2.xml");
                try {
                    i.set_locale("fr");
                    var e = i.find_all();
                    assert(e != null);
                    // Check expected number of entries
                    assert(e.length == 237);
                    // Check first and last translated entry
                    assert(e[0].country == "DE");
                    assert(e[0].type == "State");
                    assert(e[0].code == "DE-BW");
                    assert(e[0].parent == "");
                    assert(e[0].name == "Bade-Wurtemberg");
                    assert(e[234].country == "ES");
                    assert(e[234].type == "Province");
                    assert(e[234].code == "ES-Z");
                    assert(e[234].parent == "AR");
                    assert(e[234].name == "Saragosse");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_3166_2/3.x/call find_code() without argument", () => {
                var i = new ISO_3166_2();
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
            Test.add_func("/iso_3166_2/3.x/search empty code", () => {
                var i = new ISO_3166_2();
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
            Test.add_func("/iso_3166_2/3.x/find code 'de-hh'", () => {
                var i = new ISO_3166_2();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_3166_2.xml");
                try {
                    var e = i.find_code("de-hh");
                    assert(i.get_iso_codes_xml_version() == "3");
                    assert(e != null);
                    assert(e is ISO_3166_2_Entry);
                    assert(e.country == "DE");
                    assert(e.type == "State");
                    assert(e.code == "DE-HH");
                    assert(e.parent == "");
                    assert(e.name == "Hamburg");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_3166_2/3.x/find code 'FR-78'", () => {
                var i = new ISO_3166_2();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_3166_2.xml");
                try {
                    var e = i.find_code("FR-78");
                    assert(e != null);
                    assert(e is ISO_3166_2_Entry);
                    assert(e.country == "FR");
                    assert(e.type == "Metropolitan department");
                    assert(e.code == "FR-78");
                    assert(e.parent == "J");
                    assert(e.name == "Yvelines");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_3166_2/3.x/find code 'ES-C'", () => {
                var i = new ISO_3166_2();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_3166_2.xml");
                try {
                    var e = i.find_code("ES-C");
                    assert(e != null);
                    assert(e is ISO_3166_2_Entry);
                    assert(e.country == "ES");
                    assert(e.type == "Province");
                    assert(e.code == "ES-C");
                    assert(e.parent == "GA");
                    assert(e.name == "A Coruña");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_3166_2/3.x/search non existant code", () => {
                var i = new ISO_3166_2();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_3166_2.xml");
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
            Test.add_func("/iso_3166_2/3.x/find code 'DE-HH' in locale 'fr'", () => {
                var i = new ISO_3166_2();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_3166_2.xml");
                try {
                    i.set_locale("fr");
                    var e = i.find_code("DE-HH");
                    assert(e != null);
                    assert(e is ISO_3166_2_Entry);
                    assert(e.country == "DE");
                    assert(e.type == "State");
                    assert(e.code == "DE-HH");
                    assert(e.parent == "");
                    assert(e.name == "Hambourg");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_3166_2/3.x/find code 'NO-15' in non existant locale", () => {
                var i = new ISO_3166_2();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_3166_2.xml");
                try {
                    i.set_locale("does-not-exist");
                    var e = i.find_code("NO-15");
                    assert(e != null);
                    assert(e is ISO_3166_2_Entry);
                    assert(e.country == "NO");
                    assert(e.type == "County");
                    assert(e.code == "NO-15");
                    assert(e.parent == "");
                    assert(e.name == "Møre og Romsdal");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
        }
    }
}
