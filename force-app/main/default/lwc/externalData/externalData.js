import { LightningElement, wire } from "lwc";
import fetchDataFromExternalApi from "@salesforce/apex/ExternalDataCTRL.fetchDataFromExternalApi";
const columns = [
  { label: "Amount", fieldName: "amount" },
  { label: "Game Name", fieldName: "gameName" },
  { label: "Lot", fieldName: "lot" },
  { label: "Player Name", fieldName: "playerName" },
  { label: "Status", fieldName: "status" },
  { label: "Win Rate", fieldName: "winRate" }
];
export default class ExternalData extends LightningElement {
  error;
  columns = columns;
  @wire(fetchDataFromExternalApi) externalApiDataList;
}
