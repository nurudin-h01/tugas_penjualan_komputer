/**
 * @preserve date-and-time.js locale configuration
 * @preserve Greek (el)
 * @preserve It is using moment.js locale configuration as a reference.
 */
(function (global) {
    'use strict';

    var locale = function (date) {
        date.setLocales('el', {
            MMMM: {
                nominative: ['Ιανουάριος', 'Φεβρουάριος', 'Μάρτιος', 'Απρίλιος', 'Μάιος', 'Ιούνιος', 'Ιούλιος', 'Αύγουστος', 'Σεπτέμβριος', 'Οκτώβριος', 'Νοέμβριος', 'Δεκέμβριος'],
                genitive: ['Ιανουαρίου', 'Φεβρουαρίου', 'Μαρτίου', 'Απριλίου', 'Μαΐου', 'Ιουνίου', 'Ιουλίου', 'Αυγούστου', 'Σεπτεμβρίου', 'Οκτωβρίου', 'Νοεμβρίου', 'Δεκεμβρίου']
            },
            MMM: ['Ιαν', 'Φεβ', 'Μαρ', 'Απρ', 'Μαϊ', 'Ιουν', 'Ιουλ', 'Αυγ', 'Σεπ', 'Οκτ', 'Νοε', 'Δεκ'],
            dddd: ['Κυριακή', 'Δευτέρα', 'Τρίτη', 'Τετάρτη', 'Πέμπτη', 'Παρασκευή', 'Σάββατο'],
            ddd: ['Κυρ', 'Δευ', 'Τρι', 'Τετ', 'Πεμ', 'Παρ', 'Σαβ'],
            dd: ['Κυ', 'Δε', 'Τρ', 'Τε', 'Πε', 'Πα', 'Σα'],
            A: ['πμ', 'μμ'],
            formatter: {
                MMMM: function (d, formatString) {
                    return this.MMMM[/D.*MMMM/.test(formatString) ? 'genitive' : 'nominative'][d.getMonth()];
                },
                hh: function (d) {
                    return ('0' + d.getHours() % 12).slice(-2);
                },
                h: function (d) {
                    return d.getHours() % 12;
                }
            },
            parser: {
                MMMM: function (str, formatString) {
                    return this.parser.find(this.MMMM[/D.*MMMM/.test(formatString) ? 'genitive' : 'nominative'], str);
                }
            }
        });
    };

    if (typeof module === 'object' && typeof module.exports === 'object') {
        locale(require('../date-and-time'));
    } else if (typeof define === 'function' && define.amd) {
        define(['date-and-time'], locale);
    } else {
        locale(global.date);
    }

}(this));
