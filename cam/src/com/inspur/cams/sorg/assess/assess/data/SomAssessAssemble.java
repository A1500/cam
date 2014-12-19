package com.inspur.cams.sorg.assess.assess.data;

import java.util.ArrayList;
import java.util.List;

import com.inspur.cams.sorg.assess.assessconfig.data.SomAssessConfig;


public class SomAssessAssemble {
	private SomAssessConfig thisLevelData = null;
	private List<SomAssessAssemble> lowerLevelAssessAssembleList = new ArrayList();
	
	public String getLowerLevelCount(){
		if(this.lowerLevelAssessAssembleList != null){
			return this.lowerLevelAssessAssembleList.size()+"";
		}else{
			return "0";
		}
		
	}

	public SomAssessConfig getThisLevelData() {
		return thisLevelData;
	}

	public void setThisLevelData(SomAssessConfig thisLevelData) {
		this.thisLevelData = thisLevelData;
	}

	public List<SomAssessAssemble> getLowerLevelAssessAssembleList() {
		return lowerLevelAssessAssembleList;
	}

	public void setLowerLevelAssessAssembleList(
			List<SomAssessAssemble> lowerLevelAssessAssembleList) {
		this.lowerLevelAssessAssembleList = lowerLevelAssessAssembleList;
	}





}
