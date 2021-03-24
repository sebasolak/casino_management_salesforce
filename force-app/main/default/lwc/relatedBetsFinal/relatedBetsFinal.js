import { LightningElement, track ,api, wire} from 'lwc';
import getBetsList from '@salesforce/apex/BetCTRLFinal.getBetsList'
const columns = [
    { label: 'Name', fieldName: 'Name' },    
    { label: 'Amount', fieldName: 'Amount__c' },
    { label: 'Status', fieldName: 'Status__c' },
    { label: 'Win Rate', fieldName: 'Win_Rate__c' }    
];
export default class RelatedBetsFinal extends LightningElement {
   error;
   columns = columns;
    @api recordId;   
    @wire(getBetsList,{playerId: '$recordId'}) betsList;
}