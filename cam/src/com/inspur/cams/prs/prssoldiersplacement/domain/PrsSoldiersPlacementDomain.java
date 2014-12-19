package com.inspur.cams.prs.prssoldiersplacement.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.prs.prssoldiersplacement.dao.IPrsSoldiersPlacementDao;
import com.inspur.cams.prs.prssoldiersplacement.dao.PrsSoldiersPlacement;

public class PrsSoldiersPlacementDomain implements IPrsSoldiersPlacementDomain {
	
	private IPrsSoldiersPlacementDao prsSoldiersPlacementDao;

	@Reference
	public void setPrsSoldiersPlacementDao(
			IPrsSoldiersPlacementDao prsSoldiersPlacementDao) {
		this.prsSoldiersPlacementDao = prsSoldiersPlacementDao;
	}

	public DataSet query(ParameterSet pset) {
		return prsSoldiersPlacementDao.query(pset);
	}

	public void save(List<PrsSoldiersPlacement> list) {
		prsSoldiersPlacementDao.save(list);

	}

}
