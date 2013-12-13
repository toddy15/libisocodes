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
    public class Test_ISO_4217 : Object
    {
        public static void add_tests()
        {
            Test.add_func("/iso_4217/3.x/create class", () => {
                var i = new ISO_4217();
                assert(i != null);
                assert(i.standard == "4217");
                assert(i.get_filepath() == "/usr/share/xml/iso-codes/iso_4217.xml");
            });
            Test.add_func("/iso_4217/3.x/create class with changed filepath", () => {
                var i = new ISO_4217();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_4217.xml");
                assert(i.get_filepath() == Config.TESTDIR + "/3.x/iso_4217.xml");
                assert(i.standard == "4217");
                try {
                    assert(i.get_iso_codes_xml_version() == "3");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_4217/3.x/find all codes", () => {
                var i = new ISO_4217();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_4217.xml");
                try {
                    var e = i.find_all();
                    assert(i.get_iso_codes_xml_version() == "3");
                    assert(e != null);
                    // Check expected number of entries
                    assert(e.length == 3);
                    // Check first and last entry
                    assert(e[0].letter_code == "EUR");
                    assert(e[0].numeric_code == "978");
                    assert(e[0].name == "Euro");
                    assert(e[e.length-1].letter_code == "INR");
                    assert(e[e.length-1].numeric_code == "356");
                    assert(e[e.length-1].name == "Indian Rupee");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_4217/3.x/find all codes in locale 'fr'", () => {
                var i = new ISO_4217();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_4217.xml");
                try {
                    i.set_locale("fr");
                    var e = i.find_all();
                    assert(e != null);
                    // Check expected number of entries
                    assert(e.length == 3);
                    // Check first and last translated entry
                    assert(e[0].letter_code == "EUR");
                    assert(e[0].numeric_code == "978");
                    assert(e[0].name == "Euro");
                    assert(e[e.length-1].letter_code == "INR");
                    assert(e[e.length-1].numeric_code == "356");
                    assert(e[e.length-1].name == "Roupie indienne");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_4217/3.x/call find_code() without argument", () => {
                var i = new ISO_4217();
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
            Test.add_func("/iso_4217/3.x/search empty code", () => {
                var i = new ISO_4217();
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
            Test.add_func("/iso_4217/3.x/find code 'EUR'", () => {
                var i = new ISO_4217();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_4217.xml");
                try {
                    var e = i.find_code("EUR");
                    assert(i.get_iso_codes_xml_version() == "3");
                    assert(e != null);
                    assert(e is ISO_4217_Item);
                    assert(e.letter_code == "EUR");
                    assert(e.numeric_code == "978");
                    assert(e.name == "Euro");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_4217/3.x/find code '826'", () => {
                var i = new ISO_4217();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_4217.xml");
                try {
                    var e = i.find_code("826");
                    assert(e != null);
                    assert(e is ISO_4217_Item);
                    assert(e.letter_code == "GBP");
                    assert(e.numeric_code == "826");
                    assert(e.name == "Pound Sterling");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_4217/3.x/find code 'inR'", () => {
                var i = new ISO_4217();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_4217.xml");
                try {
                    var e = i.find_code("inR");
                    assert(e != null);
                    assert(e is ISO_4217_Item);
                    assert(e.letter_code == "INR");
                    assert(e.numeric_code == "356");
                    assert(e.name == "Indian Rupee");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_4217/3.x/search non existant code", () => {
                var i = new ISO_4217();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_4217.xml");
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
            Test.add_func("/iso_4217/3.x/find code 'GBP' in locale 'de'", () => {
                var i = new ISO_4217();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_4217.xml");
                try {
                    i.set_locale("de");
                    var e = i.find_code("GBP");
                    assert(e != null);
                    assert(e is ISO_4217_Item);
                    assert(e.letter_code == "GBP");
                    assert(e.numeric_code == "826");
                    assert(e.name == "Pfund Sterling");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_4217/3.x/find code '356' in locale 'fr'", () => {
                var i = new ISO_4217();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_4217.xml");
                try {
                    i.set_locale("fr");
                    var e = i.find_code("356");
                    assert(e != null);
                    assert(e is ISO_4217_Item);
                    assert(e.letter_code == "INR");
                    assert(e.numeric_code == "356");
                    assert(e.name == "Roupie indienne");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_4217/3.x/find code 'GBP' in non existant locale", () => {
                var i = new ISO_4217();
                i.set_filepath(Config.TESTDIR + "/3.x/iso_4217.xml");
                try {
                    i.set_locale("does-not-exist");
                    var e = i.find_code("GBP");
                    assert(e != null);
                    assert(e is ISO_4217_Item);
                    assert(e.letter_code == "GBP");
                    assert(e.numeric_code == "826");
                    assert(e.name == "Pound Sterling");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
        }
    }
}
