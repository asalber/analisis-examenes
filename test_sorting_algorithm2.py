import unittest
from continue_tutorial import sorting_algorithm2

class TestSortingAlgorithm2(unittest.TestCase):
    def test_empty_list(self):
        self.assertEqual(sorting_algorithm2([]), [])

    def test_sorted_list(self):
        self.assertEqual(sorting_algorithm2([1, 2, 3, 4]), [1, 2, 3, 4])

    def test_unsorted_list(self):
        self.assertEqual(sorting_algorithm2([4, 2, 3, 1]), [1, 2, 3, 4])

    def test_duplicates(self):
        self.assertEqual(sorting_algorithm2([2, 3, 1, 2]), [1, 2, 2, 3])

    def test_negative_numbers(self):
        self.assertEqual(sorting_algorithm2([-1, -3, 0, 2]), [-3, -1, 0, 2])

    def test_single_element(self):
        self.assertEqual(sorting_algorithm2([1]), [1])

if __name__ == '__main__':
    unittest.main()
