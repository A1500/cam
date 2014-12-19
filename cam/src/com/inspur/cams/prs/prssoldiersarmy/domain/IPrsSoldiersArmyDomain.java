package com.inspur.cams.prs.prssoldiersarmy.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.prs.prssoldiersarmy.dao.PrsSoldiersArmy;
@Trans
public interface IPrsSoldiersArmyDomain {
	
public DataSet query(ParameterSet pset);
	
	public void save(List<PrsSoldiersArmy> list);

}
