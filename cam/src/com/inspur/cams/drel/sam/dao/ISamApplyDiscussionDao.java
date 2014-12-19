package com.inspur.cams.drel.sam.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.sam.data.SamApplyDiscussion;

/**
 * @title:评议结果Dao
 * @description:
 * @author: yanll
 * @since:2012-05-03
 * @version:1.0
*/
 public interface ISamApplyDiscussionDao extends BaseCURD<SamApplyDiscussion>{
	public void save(List<SamApplyDiscussion> list);
}

