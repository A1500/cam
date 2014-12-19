package com.inspur.cams.prs.prssoldiersarmy.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.prs.prssoldiersarmy.dao.IPrsSoldiersArmyDao;
import com.inspur.cams.prs.prssoldiersarmy.dao.PrsSoldiersArmy;

public class PrsSoldiersArmyDomain implements IPrsSoldiersArmyDomain {
	private IPrsSoldiersArmyDao prsSoldiersArmyDao ;
	
	@Reference
	public void setPrsSoldiersArmyDao(IPrsSoldiersArmyDao prsSoldiersArmyDao) {
		this.prsSoldiersArmyDao = prsSoldiersArmyDao;
	}

	public DataSet query(ParameterSet pset) {
		return prsSoldiersArmyDao.query(pset);
	}

	public void save(List<PrsSoldiersArmy> list) {
		prsSoldiersArmyDao.save(list);
	}

}
