package com.inspur.cams.comm.soo.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.soo.data.PubCamsSoo;

/**
 * @title:IPubCamsSooDao
 * @description:
 * @author:
 * @since:2011-08-11
 * @version:1.0
*/
 public interface IPubCamsSooDao extends BaseCURD<PubCamsSoo>{
	 
	@Trans
	public void save(List<PubCamsSoo> list);
}

