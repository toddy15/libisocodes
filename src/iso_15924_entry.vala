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
    public class ISO_15924_Entry : Object
    {
        public string alpha_4_code;
        public string numeric_code;
        public string name;
        internal ISO_15924_Entry(HashMap<string, string> entry)
        {
            alpha_4_code = entry["alpha_4_code"];
            numeric_code = entry["numeric_code"];
            name = entry["name"];
        }
    }
}
