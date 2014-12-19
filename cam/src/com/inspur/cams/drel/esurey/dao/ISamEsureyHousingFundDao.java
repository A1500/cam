package com.inspur.cams.drel.esurey.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.esurey.data.SamEsureyHousingFund;

/**
 * @title:ISamEsureyHousingFundDao
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 public interface ISamEsureyHousingFundDao extends BaseCURD<SamEsureyHousingFund>{
	public void save(List<SamEsureyHousingFund> list);
	public void delete(String peopleId);
	public DataSet queryExtHousingFund(ParameterSet pset);
}

