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
    public class ISO_639_3_Entry : Object
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
        internal ISO_639_3_Entry(HashMap<string, string> entry)
        {
            id = entry["id"];
            part1_code = entry["part1_code"];
            part2_code = entry["part2_code"];
            status = entry["status"];
            scope = entry["scope"];
            type = entry["type"];
            inverted_name = entry["inverted_name"];
            reference_name = entry["reference_name"];
            name = entry["name"];
            common_name = entry["common_name"];
        }
    }
}
