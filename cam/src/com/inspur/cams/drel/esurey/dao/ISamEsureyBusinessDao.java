package com.inspur.cams.drel.esurey.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.esurey.data.SamEsureyBusiness;

/**
 * @title:ISamEsureyBusinessDao
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 public interface ISamEsureyBusinessDao extends BaseCURD<SamEsureyBusiness>{
	public void save(List<SamEsureyBusiness> list);
	public void delete(String peopleId);
	public DataSet queryExtBusiness(ParameterSet pset);
}

