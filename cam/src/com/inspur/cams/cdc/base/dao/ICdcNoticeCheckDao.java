package com.inspur.cams.cdc.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.cdc.base.data.CdcNoticeCheck;

/**
 * @title:ICdcNoticeCheckDao
 * @description:
 * @author:
 * @since:2012-03-29
 * @version:1.0
*/
 public interface ICdcNoticeCheckDao extends BaseCURD<CdcNoticeCheck>{
	public void save(List<CdcNoticeCheck> list);
}

