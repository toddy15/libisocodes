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

using Xml;
using Gee;

namespace libisocodes {
    public class ISO_639_Item : Object
    {
        public string iso_639_2B_code;
        public string iso_639_2T_code;
        public string iso_639_1_code;
        public string name;
        internal ISO_639_Item(HashMap<string, string> item)
        {
            iso_639_2B_code = item["iso_639_2B_code"];
            iso_639_2T_code = item["iso_639_2T_code"];
            iso_639_1_code = item["iso_639_1_code"];
            name = item["name"];
        }
    }
}
