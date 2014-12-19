package com.inspur.cams.bpt.manage.cmd;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.data.BptCertTemplates;
import com.inspur.cams.bpt.base.domain.IBptCertTemplatesDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.CamsProperties;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptCertTemplatesCommand
 * @description:
 * @author:
 * @since:2011-11-22
 * @version:1.0
 */
public class BptCertTemplatesCommand extends BaseAjaxCommand {

	private IBptCertTemplatesDomain bptCertTemplatesDomain = ScaComponentFactory
			.getService(IBptCertTemplatesDomain.class,
					"BptCertTemplatesDomain/BptCertTemplatesDomain");

	private static final String file_dir = CamsProperties.getString("file_dir");

	/**
	 * 上传附件
	 */
	@Trans
	public void insert() {
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		UploadFile uploadFile = wrapRequest.getUploadFile("filename"); // 获得上传的模板
		String fileId = (String) getParameter("fileId"); // 模板主键id
		String suffFileName = (String) getParameter("suffFileName"); // 模板后缀名

		if (uploadFile != null) { // 如果模板不为空
			if (uploadFile.getFileSize() > 5 * 1024 * 1024) { // 设置上传文件最大值
				throw new RuntimeException("附件最大不能超过5M");
			}

			String organCode = BspUtil.getOrganCode();
			String file_domicode = organCode.substring(0, 6); // 取行政区划前六位
			String file_name = uploadFile.getFileName(); // 模板名称
			String pathDir = file_dir + "/" + file_domicode;// 上传模板目录

			File file = new File(pathDir);
			if (!file.exists()) { // 创建上传模板目录
				file.mkdirs();
			}

			/** *******查询是否已存在该地区下的模板********* */
			ParameterSet pset = new ParameterSet();
			pset.setParameter("FILE_ID", fileId);
			DataSet ds = bptCertTemplatesDomain.query(pset);

			BptCertTemplates bptCertTemplatesOld = null;
			if (ds.getCount() > 0) { // 已存在该业务类型的模板，则先删除模板
				bptCertTemplatesOld = (BptCertTemplates) ds.getRecord(0)
						.toBean(BptCertTemplates.class);
				if (!"1".equals(bptCertTemplatesOld.getIsDefault())) {
					String filePathOld = bptCertTemplatesOld.getFilePath();
					file = new File(filePathOld);
					if (file.exists()) { // 删除旧模板
						file.delete();
					}
				}
			}

			/** ***********将模板文件保存到当地硬盘文件并保存数据库信息************* */
			String file_id = IdHelp.getUUID30(); // 模板文件数据库主键

			String filePath = pathDir + "/" + file_id + "." + suffFileName; // 模板路径(防止重复)
			file = new File(filePath);
			byte[] buffer = new byte[1024 * 10];
			FileOutputStream out = null;
			InputStream in = null;
			int size = 0;
			try {
				out = new FileOutputStream(file);
				in = uploadFile.getInputStream();
				while ((size = in.read(buffer)) != -1) {
					out.write(buffer, 0, size);
					out.flush();
				}

				// 修改数据库记录
				bptCertTemplatesOld.setIsDefault("0");// 修改为非默认
				bptCertTemplatesOld.setFileName(file_name);
				bptCertTemplatesOld.setFilePath(filePath);
				bptCertTemplatesOld.setModTime(DateUtil.getDay());
				bptCertTemplatesDomain.update(bptCertTemplatesOld);

			} catch (IOException e) {
				e.printStackTrace();
			} finally { // 关闭流
				if (null != in) {
					try {
						in.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if (null != out) {
					try {
						out.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}

			}

		}

	}

	/**
	 * 验证文件是否存在
	 */
	public void ifexeit() {
		String filePath = (String) getParameter("filePath");
		File file = new File(filePath);
		setReturn("exist", file.exists());
	}
	
	/**
	 * 获取模板路径
	 */
	public void queryPath() {
		boolean ifDefault = true;
		String docPath = "";
		ParameterSet pset = new ParameterSet();
		String organCode = BspUtil.getOrganCode();
		String fileDomicile = organCode.substring(0, 6);
		String serviceType = (String)getParameter("serviceType");
		pset.setParameter("SERVICE_TYPE", serviceType);
		pset.setParameter("FILE_DOMICILE", fileDomicile);
		DataSet ds = bptCertTemplatesDomain.query(pset);
		if(ds.getCount() > 0) {
			Record record = ds.getRecord(0);
			String defaultFlag = (String)record.get("isDefault");
			if("0".equals(defaultFlag)) {
				ifDefault = false;
				docPath = (String)record.get("filePath");
			}
		}
		setReturn("ifDefault", ifDefault);
		setReturn("docPath",docPath);
	}

}
