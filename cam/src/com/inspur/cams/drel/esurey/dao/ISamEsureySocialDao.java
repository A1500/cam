package com.inspur.cams.drel.esurey.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.esurey.data.SamEsureySocial;

/**
 * @title:ISamEsureySocialDao
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 public interface ISamEsureySocialDao extends BaseCURD<SamEsureySocial>{
	public void save(List<SamEsureySocial> list);
	public void delete(String peopleId);
	public DataSet queryExtSocial(ParameterSet pset);
}

