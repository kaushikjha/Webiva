# Autogenerated from a Treetop grammar. Edits may be lost.



module UserSegmentOption
  include Treetop::Runtime

  def root
    @root ||= :multiple_operations
  end

  module MultipleOperations0
    def operations
      elements[1]
    end
  end

  module MultipleOperations1
    def operations
      elements[0]
    end

    def more
      elements[1]
    end

  end

  module MultipleOperations2
    def eval(env={})
      [operations.eval(env)] + more.elements.collect { |e| e.operations.eval(env) }
    end
  end

  def _nt_multiple_operations
    start_index = index
    if node_cache[:multiple_operations].has_key?(index)
      cached = node_cache[:multiple_operations][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_operations
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3, s3 = index, []
        s4, i4 = [], index
        loop do
          r5 = _nt_newline
          if r5
            s4 << r5
          else
            break
          end
        end
        if s4.empty?
          @index = i4
          r4 = nil
        else
          r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
        end
        s3 << r4
        if r4
          r6 = _nt_operations
          s3 << r6
        end
        if s3.last
          r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
          r3.extend(MultipleOperations0)
        else
          @index = i3
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
      if r2
        s7, i7 = [], index
        loop do
          r8 = _nt_newline
          if r8
            s7 << r8
          else
            break
          end
        end
        r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
        s0 << r7
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(MultipleOperations1)
      r0.extend(MultipleOperations2)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:multiple_operations][start_index] = r0

    r0
  end

  module Operations0
    def operation
      elements[1]
    end
  end

  module Operations1
    def not_op
      elements[0]
    end

    def operation
      elements[1]
    end

    def more
      elements[2]
    end
  end

  module Operations2
    def eval(env={})
  	[not_op.eval(env), operation.eval(env)] + more.elements.collect { |e| e.operation.eval(env) }
    end
  end

  def _nt_operations
    start_index = index
    if node_cache[:operations].has_key?(index)
      cached = node_cache[:operations][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_not
    s0 << r1
    if r1
      r2 = _nt_operation
      s0 << r2
      if r2
        s3, i3 = [], index
        loop do
          i4, s4 = index, []
          if has_terminal?('+', false, index)
            r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure('+')
            r5 = nil
          end
          s4 << r5
          if r5
            r6 = _nt_operation
            s4 << r6
          end
          if s4.last
            r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
            r4.extend(Operations0)
          else
            @index = i4
            r4 = nil
          end
          if r4
            s3 << r4
          else
            break
          end
        end
        r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
        s0 << r3
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Operations1)
      r0.extend(Operations2)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:operations][start_index] = r0

    r0
  end

  module Operation0
    def space1
      elements[0]
    end

    def field
      elements[1]
    end

    def operation
      elements[3]
    end

    def lparen
      elements[4]
    end

    def arguments
      elements[5]
    end

    def rparen
      elements[6]
    end

    def child
      elements[7]
    end

    def space2
      elements[8]
    end
  end

  module Operation1
    def eval(env={})
      {:field => field.eval(env), :operation => operation.eval(env), :arguments => arguments.eval(env), :child => child.eval(env)}
    end
  end

  def _nt_operation
    start_index = index
    if node_cache[:operation].has_key?(index)
      cached = node_cache[:operation][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_space
    s0 << r1
    if r1
      r2 = _nt_field
      s0 << r2
      if r2
        if has_terminal?('.', false, index)
          r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('.')
          r3 = nil
        end
        s0 << r3
        if r3
          r4 = _nt_operation_name
          s0 << r4
          if r4
            r5 = _nt_lparen
            s0 << r5
            if r5
              r6 = _nt_arguments
              s0 << r6
              if r6
                r7 = _nt_rparen
                s0 << r7
                if r7
                  r8 = _nt_sub_operations
                  s0 << r8
                  if r8
                    r9 = _nt_space
                    s0 << r9
                  end
                end
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Operation0)
      r0.extend(Operation1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:operation][start_index] = r0

    r0
  end

  module SubOperations0
    def field
      elements[1]
    end

    def operation_name
      elements[3]
    end

    def lparen
      elements[4]
    end

    def arguments
      elements[5]
    end

    def rparen
      elements[6]
    end
  end

  module SubOperations1
    def eval(env={})
      if empty?
        nil
      else
        child = nil
        elements.reverse.each do |e| 
          child = {:field => e.field.eval(env), :operation => e.operation_name.eval(env), :arguments => e.arguments.eval(env), :child => child}
        end
        child
      end
    end
  end

  def _nt_sub_operations
    start_index = index
    if node_cache[:sub_operations].has_key?(index)
      cached = node_cache[:sub_operations][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      i1, s1 = index, []
      if has_terminal?('.', false, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure('.')
        r2 = nil
      end
      s1 << r2
      if r2
        r3 = _nt_field
        s1 << r3
        if r3
          if has_terminal?('.', false, index)
            r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure('.')
            r4 = nil
          end
          s1 << r4
          if r4
            r5 = _nt_operation_name
            s1 << r5
            if r5
              r6 = _nt_lparen
              s1 << r6
              if r6
                r7 = _nt_arguments
                s1 << r7
                if r7
                  r8 = _nt_rparen
                  s1 << r8
                end
              end
            end
          end
        end
      end
      if s1.last
        r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
        r1.extend(SubOperations0)
      else
        @index = i1
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
    r0.extend(SubOperations1)

    node_cache[:sub_operations][start_index] = r0

    r0
  end

  module Field0
  end

  module Field1
    def eval(env={})
      text_value
    end
  end

  def _nt_field
    start_index = index
    if node_cache[:field].has_key?(index)
      cached = node_cache[:field][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?('\G[a-zA-Z]', true, index)
      r1 = true
      @index += 1
    else
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        if has_terminal?('\G[a-zA-Z0-9_]', true, index)
          r3 = true
          @index += 1
        else
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Field0)
      r0.extend(Field1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:field][start_index] = r0

    r0
  end

  module OperationName0
  end

  module OperationName1
    def eval(env={})
      text_value
    end
  end

  def _nt_operation_name
    start_index = index
    if node_cache[:operation_name].has_key?(index)
      cached = node_cache[:operation_name][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?('\G[a-zA-Z]', true, index)
      r1 = true
      @index += 1
    else
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        if has_terminal?('\G[a-zA-Z0-9_]', true, index)
          r3 = true
          @index += 1
        else
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(OperationName0)
      r0.extend(OperationName1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:operation_name][start_index] = r0

    r0
  end

  module Arguments0
    def argument
      elements[1]
    end
  end

  module Arguments1
    def arg
      elements[0]
    end

    def more
      elements[1]
    end
  end

  module Arguments2
    def eval(env={})
      [arg.eval(env)] + more.elements.collect{ |e| e.argument.eval(env) }
    end
  end

  def _nt_arguments
    start_index = index
    if node_cache[:arguments].has_key?(index)
      cached = node_cache[:arguments][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_argument
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3, s3 = index, []
        if has_terminal?(',', false, index)
          r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure(',')
          r4 = nil
        end
        s3 << r4
        if r4
          r5 = _nt_argument
          s3 << r5
        end
        if s3.last
          r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
          r3.extend(Arguments0)
        else
          @index = i3
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Arguments1)
      r0.extend(Arguments2)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:arguments][start_index] = r0

    r0
  end

  module Argument0
    def space1
      elements[0]
    end

    def arg
      elements[1]
    end

    def space2
      elements[2]
    end
  end

  module Argument1
    def eval(env={})
      arg.eval(env)
    end
  end

  def _nt_argument
    start_index = index
    if node_cache[:argument].has_key?(index)
      cached = node_cache[:argument][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_space
    s0 << r1
    if r1
      i2 = index
      r3 = _nt_string
      if r3
        r2 = r3
      else
        r4 = _nt_integer
        if r4
          r2 = r4
        else
          r5 = _nt_float
          if r5
            r2 = r5
          else
            r6 = _nt_boolean
            if r6
              r2 = r6
            else
              @index = i2
              r2 = nil
            end
          end
        end
      end
      s0 << r2
      if r2
        r7 = _nt_space
        s0 << r7
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Argument0)
      r0.extend(Argument1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:argument][start_index] = r0

    r0
  end

  module String0
  end

  module String1
  end

  module String2
    def eval(env={})
      text_value[1..-2]
    end
  end

  def _nt_string
    start_index = index
    if node_cache[:string].has_key?(index)
      cached = node_cache[:string][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?('"', false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('"')
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3 = index
        i4, s4 = index, []
        i5 = index
        if has_terminal?('"', false, index)
          r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('"')
          r6 = nil
        end
        if r6
          r5 = nil
        else
          @index = i5
          r5 = instantiate_node(SyntaxNode,input, index...index)
        end
        s4 << r5
        if r5
          if index < input_length
            r7 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("any character")
            r7 = nil
          end
          s4 << r7
        end
        if s4.last
          r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
          r4.extend(String0)
        else
          @index = i4
          r4 = nil
        end
        if r4
          r3 = r4
        else
          if has_terminal?('\"', false, index)
            r8 = instantiate_node(SyntaxNode,input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure('\"')
            r8 = nil
          end
          if r8
            r3 = r8
          else
            @index = i3
            r3 = nil
          end
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
      if r2
        if has_terminal?('"', false, index)
          r9 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('"')
          r9 = nil
        end
        s0 << r9
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(String1)
      r0.extend(String2)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:string][start_index] = r0

    r0
  end

  module Integer0
  end

  module Integer1
    def eval(env={})
      text_value.to_i
    end
  end

  def _nt_integer
    start_index = index
    if node_cache[:integer].has_key?(index)
      cached = node_cache[:integer][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if has_terminal?('\G[1-9]', true, index)
      r2 = true
      @index += 1
    else
      r2 = nil
    end
    s1 << r2
    if r2
      s3, i3 = [], index
      loop do
        if has_terminal?('\G[0-9]', true, index)
          r4 = true
          @index += 1
        else
          r4 = nil
        end
        if r4
          s3 << r4
        else
          break
        end
      end
      r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
      s1 << r3
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Integer0)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
      r0.extend(Integer1)
    else
      if has_terminal?('0', false, index)
        r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure('0')
        r5 = nil
      end
      if r5
        r0 = r5
        r0.extend(Integer1)
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:integer][start_index] = r0

    r0
  end

  module Boolean0
    def eval(env={})
      if text_value.downcase == 'true'
        true
      else
        false
      end
    end
  end

  def _nt_boolean
    start_index = index
    if node_cache[:boolean].has_key?(index)
      cached = node_cache[:boolean][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    if has_terminal?('true', false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 4))
      @index += 4
    else
      terminal_parse_failure('true')
      r1 = nil
    end
    if r1
      r0 = r1
      r0.extend(Boolean0)
    else
      if has_terminal?('TRUE', false, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 4))
        @index += 4
      else
        terminal_parse_failure('TRUE')
        r2 = nil
      end
      if r2
        r0 = r2
        r0.extend(Boolean0)
      else
        if has_terminal?('True', false, index)
          r3 = instantiate_node(SyntaxNode,input, index...(index + 4))
          @index += 4
        else
          terminal_parse_failure('True')
          r3 = nil
        end
        if r3
          r0 = r3
          r0.extend(Boolean0)
        else
          if has_terminal?('false', false, index)
            r4 = instantiate_node(SyntaxNode,input, index...(index + 5))
            @index += 5
          else
            terminal_parse_failure('false')
            r4 = nil
          end
          if r4
            r0 = r4
            r0.extend(Boolean0)
          else
            if has_terminal?('FALSE', false, index)
              r5 = instantiate_node(SyntaxNode,input, index...(index + 5))
              @index += 5
            else
              terminal_parse_failure('FALSE')
              r5 = nil
            end
            if r5
              r0 = r5
              r0.extend(Boolean0)
            else
              if has_terminal?('False', false, index)
                r6 = instantiate_node(SyntaxNode,input, index...(index + 5))
                @index += 5
              else
                terminal_parse_failure('False')
                r6 = nil
              end
              if r6
                r0 = r6
                r0.extend(Boolean0)
              else
                @index = i0
                r0 = nil
              end
            end
          end
        end
      end
    end

    node_cache[:boolean][start_index] = r0

    r0
  end

  module Float0
  end

  module Float1
  end

  module Float2
  end

  module Float3
    def eval(env={})
      text_value.to_f
    end
  end

  def _nt_float
    start_index = index
    if node_cache[:float].has_key?(index)
      cached = node_cache[:float][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if has_terminal?('\G[1-9]', true, index)
      r2 = true
      @index += 1
    else
      r2 = nil
    end
    s1 << r2
    if r2
      s3, i3 = [], index
      loop do
        if has_terminal?('\G[0-9]', true, index)
          r4 = true
          @index += 1
        else
          r4 = nil
        end
        if r4
          s3 << r4
        else
          break
        end
      end
      r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
      s1 << r3
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Float0)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i5, s5 = index, []
      if has_terminal?('.', false, index)
        r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure('.')
        r6 = nil
      end
      s5 << r6
      if r6
        s7, i7 = [], index
        loop do
          if has_terminal?('\G[0-9]', true, index)
            r8 = true
            @index += 1
          else
            r8 = nil
          end
          if r8
            s7 << r8
          else
            break
          end
        end
        if s7.empty?
          @index = i7
          r7 = nil
        else
          r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
        end
        s5 << r7
      end
      if s5.last
        r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
        r5.extend(Float1)
      else
        @index = i5
        r5 = nil
      end
      if r5
        r0 = r5
      else
        i9, s9 = index, []
        s10, i10 = [], index
        loop do
          if has_terminal?('\G[0-9]', true, index)
            r11 = true
            @index += 1
          else
            r11 = nil
          end
          if r11
            s10 << r11
          else
            break
          end
        end
        if s10.empty?
          @index = i10
          r10 = nil
        else
          r10 = instantiate_node(SyntaxNode,input, i10...index, s10)
        end
        s9 << r10
        if r10
          if has_terminal?('.', false, index)
            r12 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure('.')
            r12 = nil
          end
          s9 << r12
          if r12
            if has_terminal?('\G[0-9]', true, index)
              r13 = true
              @index += 1
            else
              r13 = nil
            end
            s9 << r13
          end
        end
        if s9.last
          r9 = instantiate_node(SyntaxNode,input, i9...index, s9)
          r9.extend(Float2)
          r9.extend(Float3)
        else
          @index = i9
          r9 = nil
        end
        if r9
          r0 = r9
        else
          @index = i0
          r0 = nil
        end
      end
    end

    node_cache[:float][start_index] = r0

    r0
  end

  module Lparen0
    def space1
      elements[0]
    end

    def space2
      elements[2]
    end
  end

  def _nt_lparen
    start_index = index
    if node_cache[:lparen].has_key?(index)
      cached = node_cache[:lparen][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_space
    s0 << r1
    if r1
      if has_terminal?('(', false, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure('(')
        r2 = nil
      end
      s0 << r2
      if r2
        r3 = _nt_space
        s0 << r3
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Lparen0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:lparen][start_index] = r0

    r0
  end

  module Rparen0
    def space1
      elements[0]
    end

    def space2
      elements[2]
    end
  end

  def _nt_rparen
    start_index = index
    if node_cache[:rparen].has_key?(index)
      cached = node_cache[:rparen][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_space
    s0 << r1
    if r1
      if has_terminal?(')', false, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(')')
        r2 = nil
      end
      s0 << r2
      if r2
        r3 = _nt_space
        s0 << r3
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Rparen0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:rparen][start_index] = r0

    r0
  end

  module NonSpaceChar0
  end

  def _nt_non_space_char
    start_index = index
    if node_cache[:non_space_char].has_key?(index)
      cached = node_cache[:non_space_char][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    i1 = index
    if has_terminal?('\G[ ]', true, index)
      r2 = true
      @index += 1
    else
      r2 = nil
    end
    if r2
      r1 = nil
    else
      @index = i1
      r1 = instantiate_node(SyntaxNode,input, index...index)
    end
    s0 << r1
    if r1
      if index < input_length
        r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("any character")
        r3 = nil
      end
      s0 << r3
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(NonSpaceChar0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:non_space_char][start_index] = r0

    r0
  end

  module Not0
  end

  module Not1
    def space
      elements[1]
    end
  end

  module Not2
    def eval(env={})
      empty? ? nil : 'not'
    end
  end

  def _nt_not
    start_index = index
    if node_cache[:not].has_key?(index)
      cached = node_cache[:not][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    i2 = index
    i3, s3 = index, []
    if has_terminal?('\G[nN]', true, index)
      r4 = true
      @index += 1
    else
      r4 = nil
    end
    s3 << r4
    if r4
      if has_terminal?('\G[oO]', true, index)
        r5 = true
        @index += 1
      else
        r5 = nil
      end
      s3 << r5
      if r5
        if has_terminal?('\G[tT]', true, index)
          r6 = true
          @index += 1
        else
          r6 = nil
        end
        s3 << r6
        if r6
          if has_terminal?(' ', false, index)
            r7 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure(' ')
            r7 = nil
          end
          s3 << r7
        end
      end
    end
    if s3.last
      r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
      r3.extend(Not0)
    else
      @index = i3
      r3 = nil
    end
    if r3
      r2 = r3
    else
      if has_terminal?('!', false, index)
        r8 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure('!')
        r8 = nil
      end
      if r8
        r2 = r8
      else
        @index = i2
        r2 = nil
      end
    end
    if r2
      r1 = r2
    else
      r1 = instantiate_node(SyntaxNode,input, index...index)
    end
    s0 << r1
    if r1
      r9 = _nt_space
      s0 << r9
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Not1)
      r0.extend(Not2)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:not][start_index] = r0

    r0
  end

  module Newline0
    def space
      elements[0]
    end

  end

  def _nt_newline
    start_index = index
    if node_cache[:newline].has_key?(index)
      cached = node_cache[:newline][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_space
    s0 << r1
    if r1
      if has_terminal?("\n", false, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("\n")
        r2 = nil
      end
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Newline0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:newline][start_index] = r0

    r0
  end

  def _nt_space
    start_index = index
    if node_cache[:space].has_key?(index)
      cached = node_cache[:space][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      if has_terminal?('\G[ ]', true, index)
        r1 = true
        @index += 1
      else
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = instantiate_node(SyntaxNode,input, i0...index, s0)

    node_cache[:space][start_index] = r0

    r0
  end

end

class UserSegmentOptionParser < Treetop::Runtime::CompiledParser
  include UserSegmentOption
end


