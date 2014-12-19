package com.inspur.cams.prs.prssoldiersplacement.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.prs.prssoldiersplacement.dao.PrsSoldiersPlacement;

public interface IPrsSoldiersPlacementDomain {
	
	public DataSet query(ParameterSet pset);
	
	public void save(List<PrsSoldiersPlacement> list);

}
