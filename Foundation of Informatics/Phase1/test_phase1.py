from lxml import etree as ET
import sys
import itertools


def elements_equal(e1, e2):
    global diff_e1, diff_e2
    global diff

    if e1.tag != e2.tag:
        diff = "tag"
        diff_e1, diff_e2 = e1, e2
        return False

    text1 = e1.text
    text2 = e2.text

    try:
        text1 = float(text1)
        text2 = float(text2)
    except ValueError:
        pass

    if text1 != text2:
        diff = "text"
        diff_e1, diff_e2 = e1, e2
        return False
    # if e1.tail != e2.tail:
    #     diff = "tail"
    #     diff_e1, diff_e2 = e1, e2
    #     return False
    if e1.attrib != e2.attrib:
        diff = "attrib"
        diff_e1, diff_e2 = e1, e2
        return False
    if len(e1) != len(e2):
        diff = "len"
        diff_e1, diff_e2 = e1, e2
        return False
    return all(elements_equal(c1, c2) for c1, c2 in zip(e1, e2))

file1 = sys.argv[1]
file2 = sys.argv[2]

equal = True

root1 = ET.parse(open(file1, "r")).getroot()
root2 = ET.parse(open(file2, "r")).getroot()

# for ele1 in root1:
#     if not elements_equal(ele1, root2.find()):
#         equal = False
#         break

root1[:] = sorted(root1, key=lambda child: child.find('name').text)
root2[:] = sorted(root2, key=lambda child: child.find('name').text)

xpath_for_uniques = ".//uniques"

for uniques in itertools.chain(root1.iterfind(xpath_for_uniques),
                               root2.iterfind(xpath_for_uniques)):
    uniques[:] = sorted(uniques, key=lambda unique: unique.text)

if elements_equal(root1, root2):
    print("They are identical")
else:
    print("They are NOT identical" +
          "   different in " + diff +
          "    different elements are:")

    print(ET.tostring(diff_e1))
    print("=" * 30)
    print(ET.tostring(diff_e2))
