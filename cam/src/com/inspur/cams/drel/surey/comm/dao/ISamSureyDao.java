package com.inspur.cams.drel.surey.comm.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.surey.comm.data.SamSurey;

/**
 * @title:ISamSureyDao
 * @description:
 * @author:
 * @since:2011-09-29
 * @version:1.0
*/
 public interface ISamSureyDao extends BaseCURD<SamSurey>{
	public void save(List<SamSurey> list);
}

