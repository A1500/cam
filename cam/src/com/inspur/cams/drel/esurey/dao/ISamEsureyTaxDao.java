package com.inspur.cams.drel.esurey.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.esurey.data.SamEsureyTax;

/**
 * @title:ISamEsureyTaxDao
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 public interface ISamEsureyTaxDao extends BaseCURD<SamEsureyTax>{
	public void save(List<SamEsureyTax> list);
	public void delete(String peopleId);
	public DataSet queryGExtTax(ParameterSet pset);
	public DataSet queryDExtTax(ParameterSet pset);
}

