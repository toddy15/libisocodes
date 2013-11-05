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
    public class Test_ISO_639_3 : Object
    {
        public static void add_tests()
        {
            Test.add_func("/iso_639_3/create class", () => {
                var i = new ISO_639_3();
                assert(i != null);
                assert(i.standard == "639-3");
                assert(i.get_filepath() == "/usr/share/xml/iso-codes/iso_639_3.xml");
            });
            Test.add_func("/iso_639_3/create class with changed filepath", () => {
                var i = new ISO_639_3();
                i.set_filepath(Config.TESTDIR + "/iso_639_3.xml");
                assert(i.get_filepath() == Config.TESTDIR + "/iso_639_3.xml");
                assert(i.standard == "639-3");
                try {
                    assert(i.get_iso_codes_xml_version() == "3");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639_3/find all codes", () => {
                var i = new ISO_639_3();
                i.set_filepath(Config.TESTDIR + "/iso_639_3.xml");
                try {
                    var e = i.find_all();
                    assert(i.get_iso_codes_xml_version() == "3");
                    assert(e != null);
                    // Check expected number of entries
                    assert(e.length == 3);
                    // Check first and last entry
                    assert(e[0].id == "aae");
                    assert(e[0].part1_code == "");
                    assert(e[0].part2_code == "");
                    assert(e[0].status == "");
                    assert(e[0].scope == "I");
                    assert(e[0].type == "L");
                    assert(e[0].inverted_name == "");
                    assert(e[0].reference_name == "");
                    assert(e[0].name == "Albanian, Arbëreshë");
                    assert(e[0].common_name == "");
                    assert(e[e.length-1].id == "nbs");
                    assert(e[e.length-1].part1_code == "");
                    assert(e[e.length-1].part2_code == "");
                    assert(e[e.length-1].status == "");
                    assert(e[e.length-1].scope == "I");
                    assert(e[e.length-1].type == "L");
                    assert(e[e.length-1].inverted_name == "");
                    assert(e[e.length-1].reference_name == "");
                    assert(e[e.length-1].name == "Namibian Sign Language");
                    assert(e[e.length-1].common_name == "");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639_3/find all codes in locale 'fr'", () => {
                var i = new ISO_639_3();
                i.set_filepath(Config.TESTDIR + "/iso_639_3.xml");
                try {
                    i.set_locale("fr");
                    var e = i.find_all();
                    assert(e != null);
                    // Check expected number of entries
                    assert(e.length == 3);
                    // Check first and last translated entry
                    assert(e[0].id == "aae");
                    assert(e[0].part1_code == "");
                    assert(e[0].part2_code == "");
                    assert(e[0].status == "");
                    assert(e[0].scope == "I");
                    assert(e[0].type == "L");
                    assert(e[0].inverted_name == "");
                    assert(e[0].reference_name == "");
                    assert(e[0].name == "arbërisht");
                    assert(e[0].common_name == "");
                    assert(e[e.length-1].id == "nbs");
                    assert(e[e.length-1].part1_code == "");
                    assert(e[e.length-1].part2_code == "");
                    assert(e[e.length-1].status == "");
                    assert(e[e.length-1].scope == "I");
                    assert(e[e.length-1].type == "L");
                    assert(e[e.length-1].inverted_name == "");
                    assert(e[e.length-1].reference_name == "");
                    assert(e[e.length-1].name == "langue des signes namibienne");
                    assert(e[e.length-1].common_name == "");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639_3/call find_code() without argument", () => {
                var i = new ISO_639_3();
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
            Test.add_func("/iso_639_3/search empty code", () => {
                var i = new ISO_639_3();
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
            Test.add_func("/iso_639_3/find code 'deu'", () => {
                var i = new ISO_639_3();
                i.set_filepath(Config.TESTDIR + "/iso_639_3.xml");
                try {
                    var e = i.find_code("deu");
                    assert(i.get_iso_codes_xml_version() == "3");
                    assert(e != null);
                    assert(e is ISO_639_3_Entry);
                    assert(e.id == "deu");
                    assert(e.part1_code == "de");
                    assert(e.part2_code == "ger");
                    assert(e.status == "");
                    assert(e.scope == "I");
                    assert(e.type == "L");
                    assert(e.inverted_name == "");
                    assert(e.reference_name == "");
                    assert(e.name == "German");
                    assert(e.common_name == "");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639_3/find code 'De'", () => {
                var i = new ISO_639_3();
                i.set_filepath(Config.TESTDIR + "/iso_639_3.xml");
                try {
                    var e = i.find_code("De");
                    assert(e != null);
                    assert(e is ISO_639_3_Entry);
                    assert(e.id == "deu");
                    assert(e.part1_code == "de");
                    assert(e.part2_code == "ger");
                    assert(e.status == "");
                    assert(e.scope == "I");
                    assert(e.type == "L");
                    assert(e.inverted_name == "");
                    assert(e.reference_name == "");
                    assert(e.name == "German");
                    assert(e.common_name == "");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639_3/find code 'NBS'", () => {
                var i = new ISO_639_3();
                i.set_filepath(Config.TESTDIR + "/iso_639_3.xml");
                try {
                    var e = i.find_code("NBS");
                    assert(e != null);
                    assert(e is ISO_639_3_Entry);
                    assert(e.id == "nbs");
                    assert(e.part1_code == "");
                    assert(e.part2_code == "");
                    assert(e.status == "");
                    assert(e.scope == "I");
                    assert(e.type == "L");
                    assert(e.inverted_name == "");
                    assert(e.reference_name == "");
                    assert(e.name == "Namibian Sign Language");
                    assert(e.common_name == "");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639_3/find code 'ger'", () => {
                var i = new ISO_639_3();
                i.set_filepath(Config.TESTDIR + "/iso_639_3.xml");
                try {
                    var e = i.find_code("ger");
                    assert(e != null);
                    assert(e is ISO_639_3_Entry);
                    assert(e.id == "deu");
                    assert(e.part1_code == "de");
                    assert(e.part2_code == "ger");
                    assert(e.status == "");
                    assert(e.scope == "I");
                    assert(e.type == "L");
                    assert(e.inverted_name == "");
                    assert(e.reference_name == "");
                    assert(e.name == "German");
                    assert(e.common_name == "");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639_3/search non existant code", () => {
                var i = new ISO_639_3();
                i.set_filepath(Config.TESTDIR + "/iso_639_3.xml");
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
            Test.add_func("/iso_639_3/find code 'de' in locale 'fr'", () => {
                var i = new ISO_639_3();
                i.set_filepath(Config.TESTDIR + "/iso_639_3.xml");
                try {
                    i.set_locale("fr");
                    var e = i.find_code("de");
                    assert(e != null);
                    assert(e is ISO_639_3_Entry);
                    assert(e.id == "deu");
                    assert(e.part1_code == "de");
                    assert(e.part2_code == "ger");
                    assert(e.status == "");
                    assert(e.scope == "I");
                    assert(e.type == "L");
                    assert(e.inverted_name == "");
                    assert(e.reference_name == "");
                    assert(e.name == "allemand");
                    assert(e.common_name == "");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639_3/find code 'aaE' in locale 'de'", () => {
                var i = new ISO_639_3();
                i.set_filepath(Config.TESTDIR + "/iso_639_3.xml");
                try {
                    i.set_locale("de");
                    var e = i.find_code("aaE");
                    assert(e != null);
                    assert(e is ISO_639_3_Entry);
                    assert(e.id == "aae");
                    assert(e.part1_code == "");
                    assert(e.part2_code == "");
                    assert(e.status == "");
                    assert(e.scope == "I");
                    assert(e.type == "L");
                    assert(e.inverted_name == "");
                    assert(e.reference_name == "");
                    assert(e.name == "Albanisch, Arbëreshë");
                    assert(e.common_name == "");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
            Test.add_func("/iso_639_3/find code 'nbs' in non existant locale", () => {
                var i = new ISO_639_3();
                i.set_filepath(Config.TESTDIR + "/iso_639_3.xml");
                try {
                    i.set_locale("does-not-exist");
                    var e = i.find_code("nbs");
                    assert(e != null);
                    assert(e is ISO_639_3_Entry);
                    assert(e.id == "nbs");
                    assert(e.part1_code == "");
                    assert(e.part2_code == "");
                    assert(e.status == "");
                    assert(e.scope == "I");
                    assert(e.type == "L");
                    assert(e.inverted_name == "");
                    assert(e.reference_name == "");
                    assert(e.name == "Namibian Sign Language");
                    assert(e.common_name == "");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
        }
    }
}
