package com.inspur.cams.cdc.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.cdc.base.data.CdcElectionGroup;

/**
 * @title:ICdcElectionGroupDao
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
 public interface ICdcElectionGroupDao extends BaseCURD<CdcElectionGroup>{
	public void save(List<CdcElectionGroup> list);
}

