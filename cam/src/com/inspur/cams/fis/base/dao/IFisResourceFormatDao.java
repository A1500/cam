package com.inspur.cams.fis.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.fis.base.data.FisResourceFormat;

/**
 * @Path com.inspur.cams.fis.base.dao.IFisResourceFormatDao  
 * @Description: TODO 殡葬业务资源规格表dao接口
 * @author wangziming
 * @date 2011-11-15
 */
 public interface IFisResourceFormatDao extends BaseCURD<FisResourceFormat>{
	public void save(List<FisResourceFormat> list);
}

