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
    public class ISO_3166_2_Entry : Object
    {
        public string country;
        public string type;
        public string code;
        public string parent;
        public string name;
        internal ISO_3166_2_Entry(HashMap<string, string> entry)
        {
            country = entry["country"];
            type = entry["type"];
            code = entry["code"];
            parent = entry["parent"];
            name = entry["name"];
        }
    }
}
