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

using Xml;

namespace libisocodes {
    public class ISO_3166_Entry : Object
    {
        public string alpha_2_code;
        public string alpha_3_code;
        public string numeric_code;
        public string name;
        public string official_name;
        public string common_name;
        internal ISO_3166_Entry(Xml.Node* node)
        {
            alpha_2_code = node->get_prop("alpha_2_code");
            alpha_3_code = node->get_prop("alpha_3_code");
            numeric_code = node->get_prop("numeric_code");
            name = node->get_prop("name");
            official_name = node->get_prop("official_name");
            common_name = node->get_prop("common_name");
            // Official name and common name might be null,
            // so set them to an empty string instead.
            if (official_name == null) {
                official_name = "";
            }
            if (common_name == null) {
                common_name = "";
            }
        }
    }
}
