package com.inspur.cams.fis.ep.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.fis.ep.base.data.FisCemeLandcard;

/**
 * @title: IFisCemeLandcardDao
 * @description:公墓土地证dao接口
 * @author:lidongdong(xxz)
 * @since:2011-11-11
 * @version:1.0
 */
public interface IFisCemeLandcardDao extends BaseCURD<FisCemeLandcard> {
	public void save(List<FisCemeLandcard> list);
}
