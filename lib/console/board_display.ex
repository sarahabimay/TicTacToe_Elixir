defmodule TTT.BoardDisplay do
  def formatted_board(board) do
    board
    |> format_elements
    |> format_board
    |> append_newline
  end

  defp format_elements(board) do
    board
    |> Enum.with_index
    |> Enum.map(fn({element, i}) -> format_element(element, i) end)
  end

  defp format_element(element, index) do
    if single_char?(element, index) do
      " #{element}"
    else
     "#{element}"
    end
  end

  defp format_board([i1,  i2,  i3,  i4,
                     i5,  i6,  i7,  i8,
                     i9, i10, i11, i12,
                     i13, i14, i15, i16]) do
      "[ #{i1} ][ #{i2} ][ #{i3} ][ #{i4} ]\n" <>
      "[ #{i5} ][ #{i6} ][ #{i7} ][ #{i8} ]\n" <>
      "[ #{i9} ][ #{i10} ][ #{i11} ][ #{i12} ]\n" <>
      "[ #{i13} ][ #{i14} ][ #{i15} ][ #{i16} ]"
  end

  defp format_board([i1, i2, i3,
                     i4, i5, i6,
                     i7, i8, i9]) do
      "[ #{i1} ][ #{i2} ][ #{i3} ]\n" <>
      "[ #{i4} ][ #{i5} ][ #{i6} ]\n" <>
      "[ #{i7} ][ #{i8} ][ #{i9} ]"
  end

  defp append_newline(message), do: message <> "\n"

  defp single_char?(element, index), do: element == "X" || element == "O" || index < 9
end
