package com.inspur.cams.comm.menuconfig.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.menuconfig.data.PubMenuConfig;

/**
 * @title:IPubMenuConfigDao
 * @description:
 * @author:
 * @since:2011-08-09
 * @version:1.0
*/
 public interface IPubMenuConfigDao extends BaseCURD<PubMenuConfig>{
	@Trans
	public void save(List<PubMenuConfig> list);

	@Trans
	public int exeUpdate(String sql);

	@Trans
	public int exeUpdate(String sql, int[] types, Object[] args);
}

