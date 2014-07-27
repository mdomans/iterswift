//
//  itertools.swift
//  itertools
//
//  Created by mdomans on 26/07/14.
//  Copyright (c) 2014 mdomans. All rights reserved.
//

import Foundation

struct cycleGenerator<S: Sequence, T where T == S.GeneratorType.Element>: Generator {
    var seq: S
    var gen: S.GeneratorType
    
    init (seq:S) {
        self.seq = seq
        self.gen = seq.generate()
    }
    
    mutating func next() -> T? {
        let n = self.gen.next()
        if n {
            return n
        } else {
            self.gen = self.seq.generate()
            return self.gen.next()
        }
    }
}

struct cycleSequence<S:Sequence>: Sequence {
    var seq:S
    func generate() -> cycleGenerator<S, S.GeneratorType.Element> {
        return cycleGenerator(seq: seq)
    }
}

struct zipGenerator <S: Sequence, T where T == S.GeneratorType.Element> : Generator {
    var sequences: [S]
    var generators: [S.GeneratorType]
    
    init(sequences:[S]) {
        self.sequences = sequences
        self.generators = []
        for s in sequences {
            self.generators.append(s.generate())
        }
    }
    
    mutating func next () -> [T]? {
        var container:[S.GeneratorType.Element] = []
        for (index, value) in enumerate(self.generators) {
            let n = self.generators[index].next()
            if n {
                container.append(n!)
            } else {
                return nil;
            }
        }
        return container
    }
}

struct zipSequence<S:Sequence>: Sequence {
    var sequences:[S]
    func generate() -> zipGenerator <S, S.GeneratorType.Element> {
        return zipGenerator(sequences: self.sequences)
    }
}

func cycle <S:Sequence>(initialSequence:S) -> cycleSequence<S> {
    return cycleSequence(seq: initialSequence)
}

func izip <S:Sequence>(sequences:S...) -> zipSequence<S> {
    return zipSequence(sequences: sequences)
}

