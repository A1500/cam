package com.inspur.cams.drel.sam.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.sam.data.SamApplyNotice;

/**
 * @title:公示结果Dao
 * @description:
 * @author: yanll
 * @since:2012-05-03
 * @version:1.0
*/
 public interface ISamApplyNoticeDao extends BaseCURD<SamApplyNotice>{
	public void save(List<SamApplyNotice> list);
}

