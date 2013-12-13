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
    public class ISO_639_3_Item : Object
    {
        public string id;
        public string part1_code;
        public string part2_code;
        public string status;
        public string scope;
        public string type;
        public string inverted_name;
        public string reference_name;
        public string name;
        public string common_name;
        internal ISO_639_3_Item(HashMap<string, string> item)
        {
            id = item["id"];
            part1_code = item["part1_code"];
            part2_code = item["part2_code"];
            status = item["status"];
            scope = item["scope"];
            type = item["type"];
            inverted_name = item["inverted_name"];
            reference_name = item["reference_name"];
            name = item["name"];
            common_name = item["common_name"];
        }
    }
}
