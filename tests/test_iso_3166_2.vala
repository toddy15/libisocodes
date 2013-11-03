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
            Test.add_func("/iso_3166_2/create class", () => {
                var i = new ISO_3166_2();
                assert(i != null);
                assert(i.standard == "3166-2");
                assert(i.get_filepath() == "/usr/share/xml/iso-codes/iso_3166_2.xml");
            });
            Test.add_func("/iso_3166_2/create class with changed filepath", () => {
                var i = new ISO_3166_2();
                i.set_filepath("/this/is/a/new/path");
                assert(i.get_filepath() == "/this/is/a/new/path");
                assert(i.standard == "3166-2");
            });
            Test.add_func("/iso_3166_2/call find_code() without argument", () => {
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
            Test.add_func("/iso_3166_2/search empty code", () => {
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
            Test.add_func("/iso_3166_2/find code 'de-hh'", () => {
                var i = new ISO_3166_2();
                i.set_filepath(Config.TESTDIR + "/iso_3166_2.xml");
                try {
                    var e = i.find_code("de-hh");
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
            Test.add_func("/iso_3166_2/find code 'FR-78'", () => {
                var i = new ISO_3166_2();
                i.set_filepath(Config.TESTDIR + "/iso_3166_2.xml");
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
            Test.add_func("/iso_3166_2/find code 'ES-C'", () => {
                var i = new ISO_3166_2();
                i.set_filepath(Config.TESTDIR + "/iso_3166_2.xml");
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
            Test.add_func("/iso_3166_2/search non existant code", () => {
                var i = new ISO_3166_2();
                i.set_filepath(Config.TESTDIR + "/iso_3166_2.xml");
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
            Test.add_func("/iso_3166_2/find code 'DE-HH' in locale 'fr'", () => {
                var i = new ISO_3166_2();
                i.set_filepath(Config.TESTDIR + "/iso_3166_2.xml");
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
            Test.add_func("/iso_3166_2/find code 'NO-15' in non existant locale", () => {
                var i = new ISO_3166_2();
                i.set_filepath(Config.TESTDIR + "/iso_3166_2.xml");
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
