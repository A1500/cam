package com.inspur.cams.comm.inform.response;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IInInformResponseDao
 * @description:
 * @author:
 * @since:2009-10-28
 * @version:1.0
*/
 public interface IInInformResponseDao extends BaseCURD<InformResponse>{
	public void save(List<InformResponse> list);
}

