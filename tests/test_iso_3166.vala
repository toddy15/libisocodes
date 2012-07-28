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

namespace isocodes {
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
            Test.add_func("/iso_3166/create class with changes", () => {
                var i = new ISO_3166();
                i.filepath = "/this/is/a/new/path";
                assert(i.filepath == "/this/is/a/new/path");
            });
            Test.add_func("/iso_3166/search code", () => {
                var i = new ISO_3166();
                try {
                    var e = i.search_code("de");
                    assert(e != null);
                    assert(e is ISO_3166_Entry);
                    assert(e.name == "Germany");
                }
                catch (ISOCodesError error) {
                    assert_not_reached();
                }
            });
        }
    }
}
