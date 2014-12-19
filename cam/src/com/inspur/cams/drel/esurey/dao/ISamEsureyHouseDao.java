package com.inspur.cams.drel.esurey.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.esurey.data.SamEsureyHouse;

/**
 * @title:ISamEsureyHouseDao
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 public interface ISamEsureyHouseDao extends BaseCURD<SamEsureyHouse>{
	public void save(List<SamEsureyHouse> list);
	public void delete(String peopleId);
	public DataSet queryExtHouse(ParameterSet pset);
}

