package com.inspur.cams.drel.esurey.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.esurey.data.SamEsureyBank;

/**
 * @title:ISamEsureyBankDao
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 public interface ISamEsureyBankDao extends BaseCURD<SamEsureyBank>{
	public void save(List<SamEsureyBank> list);
	public void delete(String peopleId);
	public DataSet queryExtBank(ParameterSet pset);
}

